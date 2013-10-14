class AdministrationController < ApplicationController
  require 'rubygems'
  require 'google/api_client'
  require 'yaml'
  before_filter :set_class, :facebook_and_google, :set_resources, :user_events
  before_filter :check_auth, :except => :dashboard
  def cms_index
    @users = User.all
    @current_announcement = Announcement.where("displayed = ?", true).last
    @announcement = Announcement.new
    @posts = Post.where("publish=?", true).order("created_at desc")
    @tenants = Tenant.where("active=?", true).order("name asc")
    @alert = Alert.new
    @alerts = Alert.where("publish=?", true)
    @statement = Statement.new
    @statements = Statement.find(:all, :order => "created_at desc")
  end
  
  def send_email
    @user = current_user
    bg = Background.find_by_page_controller_and_page_action("pages", "index")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @apply_text = Snippet.find(3)
    @newsletter = Subscription.new
    @resume = Resume.new
    @tenant_application = TenantApplication.new
    @tenants = Tenant.find(:all, :conditions => ["active=? and name !=?", true, "acre"], :order => "name ASC")
  	@message = Message.new(params[:message])
  	email = params[:message][:email]
  	subject = params[:subject]
  	sender = params[:from]
  	SendMail.email(sender, email, subject, @message).deliver
  	redirect_to "/administration/contact"
  end
  
  def create_alert
    @alert = Alert.create(params[:alert])
    redirect_to administration_cms_path
  end
  def remove_alert
    @alert = Alert.find(params[:id])
    @alert.update_attribute("publish", false)
    redirect_to administration_cms_path
  end
    
  def dashboard
    if current_user
      @user = current_user
      if !@user.tenant_backgrounds.find_by_page_action("dashboard").blank?
        bg = @user.tenant_backgrounds.find_by_page_action("dashboard")
        @bgimg = bg.tenant_background_image.url
        @bgheight = bg.height.to_i
        @bgwidth = bg.width.to_i
      else
        bg = Background.find_by_page_controller_and_page_action("administration", "dashboard")
        @bgimg = bg.background_image.url
        @bgheight = bg.height.to_i
        @bgwidth = bg.width.to_i
      end
      @tenant = @user.tenant
      posts = Post.where("publish = ?", true)
      #posts = Post.find(:all, :conditions => ["lower(category) = ? or lower(tag) like ? or lower(tenant) like ?", @tenant.name.downcase, "%#{@tenant.name.downcase}%", "%#{@tenant.name.downcase}%"])
      #articles = Article.find(:all, :conditions => ["lower(category) = ? or lower(tag) like ? or lower(tenant) like ?", @tenant.name.downcase, "%#@tenant.name.downcase}%", "%#{@tenant.name.downcase}%"])
      
      #feed_urls = []
      @user.news_sources.each do |s|
        FeedEntry.update_from_feed(s.feed_url, @user, s.name.blank? ? "External" : s.name)
        #feed_urls.push(s.feed_url)
      end
      FeedEntry.update_from_posts(posts, @user, "ACRE")
      #@feeds = Feedzirra::Feed.fetch_and_parse(feed_urls)
      @sources = @user.news_sources
      #@news = posts
      @entries = @user.feed_entries.paginate(:order => "published_date desc", :per_page => 20, :page => params[:page])
      
      @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc").limit(7)
      @alert = Alert.where("publish=?", true).last      
    else
      redirect_to root_path, :notice => "Access denied: Not signed in or session expired."
    end
  end
  
  def dashboard_filter
    filter = params[:filter]
    if filter == "all"
      @entries = @user.feed_entries.paginate(:order => "published_date desc", :per_page => 20, :page => params[:page])
    elsif filter == "acre"
      @entries = @user.feed_entries.paginate(:conditions => ["origin=?", "acre"], :order => "published_date desc", :per_page => 20, :page => params[:page])
    else
      @entries = @user.feed_entries.paginate(:conditions => ["origin=?", filter], :order => "published_date desc", :per_page => 20, :page => params[:page])
    end
  end
  
  def external_auth
    @auth = request.env["omniauth.auth"]
    @token = @auth["credentials"]["token"]
    @expires = @auth["credentials"]["expires_at"]
    if @auth["provider"] == "facebook"
      current_user.update_attributes(:fb_token => @token, :fb_expires_at => @expires)
      if current_user == User.find(10)
        fb_user = FacebookUser.find(1).update_attributes(:name => @auth["info"]["name"], :token => @token, :uid => @auth["uid"], :link => @auth["info"]["urls"]["Facebook"], :expires_at => @expires)
      end
    else
      current_user.update_attributes(:google_oauth => @token, :refresh_token => @auth["credentials"]["refresh_token"], :expires_at => @expires)
    end    
    redirect_to administration_root_path
  end
  
  def calendar_select
    @user = current_user
    calendar = params[:calendar]
    @user.update_attribute("selected_calendar", calendar)
  end
  
  def delete_user
    @user = User.find(params[:id])
    unless @user.role == "admin"
      @user.destroy if can? :manage, User
    end
    redirect_to administration_cms_path
  end
  
  def access_control
    @user = User.find(params[:id])
    unless @user.role == "admin"
      @user.update_attribute("admin", params[:admin]) if can? :manage, User
    end
    redirect_to administration_cms_path
  end
  
  def unapproved_resources
    @providers = Provider.where("publish!=?", true)
    @tools = Tool.where("publish!=?", true)
    @newssites = NewsSite.where("publish!=?", true)
    @grants = Grant.where("publish!=?", true)
    @resumes = Resume.where("publish!=?", true)
  end
  
  def resource_display
    @resourcetype = params[:resource]
    id = params[:id]
    case @resourcetype
    when "provider"
      @resource = Provider.find(id)
      @related =  []
      Provider.where("specialty like ? or category like ? or sector like ?", "%#{@resource.specialty}%", "%#{@resource.category}%", "%#{@resource.sector}%").each do |r|
        @related.push(r)
      end
      unless @resource.tag.blank?
        @resource.tag.split(",").collect(&:strip).each do |t|
          Provider.where("tag like ?", "%#{t}%").each do |r|
            @related.push(r)
          end
        end
      end
      unless @resource.tenant.blank?
        @resource.tenant.split(",").collect(&:strip).each do |t|
          Provider.where("tenant like ?", "%#{t}%").each do |r|
            @related.push(r)
          end
        end
      end
      @related = @related.uniq
    when "resume"
      @resource = Resume.find(id)
      @related =  []
      Resume.where("specialty like ? and publish = ?", "%#{@resource.specialty}%", true).each do |r|
        @related.push(r)
      end
      @related = @related.uniq
    when "grant"
      @resource = Grant.find(id)
      @related =  []
      Grant.where("specialty like ? or category like ? or sector like ?", "%#{@resource.specialty}%", "%#{@resource.category}%", "%#{@resource.sector}%").each do |r|
        @related.push(r)
      end
      unless @resource.tag.blank?
        @resource.tag.split(",").collect(&:strip).each do |t|
          Grant.where("tag like ?", "%#{t}%").each do |r|
            @related.push(r)
          end
        end
      end
      unless @resource.tenant.blank?
        @resource.tenant.split(",").collect(&:strip).each do |t|
          Grant.where("tenant like ?", "%#{t}%").each do |r|
            @related.push(r)
          end
        end
      end
      @related = @related.uniq
    when "tool"
      @resource = Tool.find(id)
      @related =  []
      Tool.where("specialty like ? or category like ?", "%#{@resource.specialty}%", "%#{@resource.category}%").each do |r|
        @related.push(r)
      end
      unless @resource.tag.blank?
        @resource.tag.split(",").collect(&:strip).each do |t|
          Tool.where("tag like ?", "%#{t}%").each do |r|
            @related.push(r)
          end
        end
      end
      unless @resource.tenant.blank?
        @resource.tenant.split(",").collect(&:strip).each do |t|
          Tool.where("tenant like ?", "%#{t}%").each do |r|
            @related.push(r)
          end
        end
      end
      @related = @related.uniq
    when "news_site"
      @resource = NewsSite.find(id)
      @related =  []
      NewsSite.where("specialty like ?", "%#{@resource.specialty}%").each do |r|
        @related.push(r)
      end
      unless @resource.tag.blank?
        @resource.tag.split(",").collect(&:strip).each do |t|
          NewsSite.where("tag like ?", "%#{t}%").each do |r|
            @related.push(r)
          end
        end
      end
      unless @resource.tenant.blank?
        @resource.tenant.split(",").collect(&:strip).each do |t|
          NewsSite.where("tenant like ?", "%#{t}%").each do |r|
            @related.push(r)
          end
        end
      end
      @related = @related.uniq
    end
  end
  
  def save_memo
    user = current_user
    resource_type = params[:resource]
    resource_id = params[:id]
    Memo.create(:user_id => user.id, :item_id => resource_id, :item_type => resource_type)
    #if resource_type == "userevent"
    #  cevent = CalendarEvent.find_by_event_start_and_name(UserEvent.find(resource_id).event_start, UserEvent.find(resource_id).name)
    #  Memo.create(:user_id => user.id, :item_id => cevent.id, :item_type => "calendar_event")
    #end
    uevent = user.user_events.find_by_origin_and_origin_id(resource_type, resource_id)
    unless uevent.blank?
      Memo.create(:user_id => user.id, :item_id => uevent.id, :item_type => "userevent")
    end
  end
  
  def resources
    @user = current_user
    if !@user.tenant_backgrounds.find_by_page_action("resources").blank?
      bg = @user.tenant_backgrounds.find_by_page_action("resources")
      @bgimg = bg.tenant_background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    else
      bg = Background.find_by_page_controller_and_page_action("administration", "resources")
      @bgimg = bg.background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    end
    @tenant = @user.tenant
    @tenants = Tenant.find(:all, :conditions => ["publish=? and lower(name) !=?", true, "acre"], :order => "name ASC")
    @providers = Provider.where("publish=?", true).order("specialty asc")
    @grants = Grant.where("publish=?", true).order("specialty asc")
    @resumes = Resume.find(:all, :conditions => ["publish=?", true], :order => "specialty asc")
    @tools = Tool.where("publish=?", true).order("specialty asc")
    @news = NewsSite.where("publish=?", true).order("specialty asc")
    
    #@recent_providers = Provider.where("publish=? and created_at > ?", true, 5.days.ago).limit(5)
    #@recent_grants = Grant.where("publish=? and created_at > ?", true, 5.days.ago).limit(5)
    #@recent_resumes = Resume.where("created_at > ?", 5.days.ago).limit(5)
    #@recent_contacts = Contact.where("publish=? and created_at > ?", true, 5.days.ago).limit(5)
    #@recent_news = NewsSite.where("publish=? and created_at > ?", true, 5.days.ago).limit(5)
    @recent_providers = Provider.where("publish=?", true).order("created_at desc").limit(5)
    @recent_grants = Grant.where("publish=?", true).order("created_at desc").limit(5)
    @recent_resumes = Resume.find(:all, :conditions => ["publish=?", true], :order => "created_at desc", :limit => 5)
    @recent_tools = Tool.where("publish=?", true).order("created_at desc").limit(5)
    @recent_news = NewsSite.where("publish=?", true).order("created_at desc").limit(5)
    
    @specialty_providers = @providers.group_by {|p| p.specialty}
    @specialty_resumes = @resumes.group_by {|r| r.specialty}
    @specialty_grants = @grants.group_by {|g| g.specialty}
    @specialty_tools = @tools.group_by {|c| c.specialty}
    @specialty_news = @news.group_by {|n| n.specialty}
    @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc").limit(7)
  end
  
  def resource_search
    term = params[:query]
    @resource = params[:resource]
    case @resource
    when "provider"
      @search_results = Provider.where("name like ? and publish = ? or description like ? and publish = ? or specialty like ? and publish = ? or author like ? and publish = ? or content like ? and publish = ? or tag like ? and publish = ? or category like ? and publish = ? or sector like ? and publish = ? or tenant like ? and publish = ?", "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true)
    when "resume"
      @search_results = Resume.where("name like ? and publish = ? or specialty like ? and publish = ? or cover_letter like ? and publish = ?", "%#{term}%", true, "%#{term}%", true, "%#{term}%", true)
    when "grant"
      @search_results = Grant.where("name like ? and publish = ? or description like ? and publish = ? or specialty like ? and publish = ? or author like ? and publish = ? or content like ? and publish = ? or tag like ? and publish = ? or category like ? and publish = ? or sector like ? and publish = ? or tenant like ? and publish = ?", "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true)
    when "tool"
      @search_results = Tool.where("name like ? and publish = ? or description like ? and publish = ? or specialty like ? and publish = ? or tag like ? and publish = ? or category like ? and publish = ?", "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true)
    when "news"
      @search_results = NewsSite.where("name like ? and publish = ? or website like ? and publish = ? or description like ? and publish = ? or specialty like ? and publish = ? or author like ? and publish = ? or content like ? and publish = ? or tag like ? and publish = ? or category like ? and publish = ? or sector like ? and publish = ? or tenant like ? and publish = ?", "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true, "%#{term}%", true)
    else
      @search_results = ["Nothing found"]
    end
  end
  
  def filter_resources
    @resource = params[:resource]
    @filter = params[:filter]
    case @resource
    when "provider"
      case @filter
      when "recent"
        @results = Provider.where("publish=? and created_at > ?", true, 5.days.ago)
      when "specialty"
        @results = Provider.where("publish=?", true).group_by {|p| p.specialty}
      when "saved"
        @results = []
        Provider.where("publish=?", true).each do |p|
          if p.saved?(current_user)
            @results.push(p)
          end
        end
      else
        @results = Provider.where("publish=?", true)
      end
    when "resume"
      case @filter
      when "recent"
        @results = Resume.where("created_at > ?", 5.days.ago)
      when "specialty"
        @results = Resume.all.group_by {|p| p.specialty}
      when "yours"
        @results = current_user.tenant.resumes
      when "saved"
        @results = []
        Resume.all.each do |r|
          if r.saved?(current_user)
            @results.push(r)
          end
        end
      else
        @results = Resume.all
      end
    when "grant"
      case @filter
      when "recent"
        @results = Grant.where("publish=? and created_at > ?", true, 5.days.ago)
      when "specialty"
        @results = Grant.where("publish=?", true).group_by {|p| p.specialty}
      when "saved"
        @results = []
        Grant.where("publish=?", true).each do |g|
          if g.saved?(current_user)
            @results.push(g)
          end
        end
      else
        @results = Grant.where("publish=?", true)
      end
    when "tool"
      case @filter
      when "recent"
        @results = Tool.where("publish=? and created_at > ?", true, 5.days.ago)
      when "specialty"
        @results = Tool.where("publish=?", true).group_by {|p| p.specialty}
      when "saved"
        @results = []
        Tool.where("publish=?", true).each do |g|
          if g.saved?(current_user)
            @results.push(g)
          end
        end
      else
        @results = Tool.where("publish=?", true)
      end
    when "news"
      case @filter
      when "recent"
        @results = NewsSite.where("publish=? and created_at > ?", true, 5.days.ago)
      when "specialty"
        @results = NewsSite.where("publish=?", true).group_by {|p| p.specialty}
      when "saved"
        @results = []
        NewsSite.where("publish=?", true).each do |g|
          if g.saved?(current_user)
            @results.push(g)
          end
        end
      else
        @results = NewsSite.where("publish=?", true)
      end
    else
      @results = ["Nothing found"]
    end
  end
  
  def news
    @user = current_user
    if !@user.tenant_backgrounds.find_by_page_action("news").blank?
      bg = @user.tenant_backgrounds.find_by_page_action("news")
      @bgimg = bg.tenant_background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    else
      bg = Background.find_by_page_controller_and_page_action("administration", "news")
      @bgimg = bg.background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    end
    @events = Event.find(:all, :order => "eventdate ASC", :limit => 6)
    @news = Post.paginate(:conditions => ["publish=? and featured=? and archive=?", true, false, false], :order => "created_at DESC", :per_page => 5, :page => params[:page])
    @features = Post.find(:all, :conditions => ["publish=? and featured=? and archive=?", true, true, false], :order => "created_at DESC", :limit => 2)
    @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc").limit(7)
  end
  
  def contact
    @user = current_user
    if !@user.tenant_backgrounds.find_by_page_action("contact").blank?
      bg = @user.tenant_backgrounds.find_by_page_action("contact")
      @bgimg = bg.tenant_background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    else
      bg = Background.find_by_page_controller_and_page_action("administration", "contact")
      @bgimg = bg.background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    end
    @tenants = Tenant.find(:all, :conditions => ["active=? and email <> ''", true], :order => "name ASC")
    @message = Message.new
    @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc").limit(7)
  end
  
  def calendar
    @user = current_user
    if !@user.tenant_backgrounds.find_by_page_action("calendar").blank?
      bg = @user.tenant_backgrounds.find_by_page_action("calendar")
      @bgimg = bg.tenant_background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    else
      bg = Background.find_by_page_controller_and_page_action("administration", "calendar")
      @bgimg = bg.background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    end
    @uevents = @user.user_events.all
  end
  
  
  def facebook_and_google
    if user_signed_in?
      @user = current_user
      #facebook stuff
      begin
        #"BAACEdEose0cBAMhRLI0fDVQb53PPZB64EPqlOSBS86d7Lbuf2sFnemmjJCDN23LXuVo04ZAffSLyOHmU8dnanjhWJrohw6snLWmRJoRBXWjfRsDNWaAk1He9lyvXPWRh4G1ZAy7vnUiJNb6AzDnhpyaEP2lLb7QKtsRzP6ZAPD8ZBTKDMTFBl7KP76REvWnR4ZCXFO2fOBoVJLtBXTBSYUTWa7mr4GG6TfTNFmEb4OggZDZD"
        fb_token = User.find(10).fb_token
        
        @user_graph = Koala::Facebook::API.new(fb_token)
        
        @feed = @user_graph.get_connection('116539501741873', 'feed')[0..2]
        
        #pages = @user_graph.get_connections('me', 'accounts')
        #first_page_token = pages.first['access_token']
        #@page_graph = Koala::Facebook::API.new(first_page_token)
        #@feed = @page_graph.get_connection('me', 'feed')[0..2]
        
        #@graph = Koala::Facebook::API.new(fb_token)
        #@feed = @graph.get_connections("me", "feed")[0..2]
      rescue Koala::Facebook::APIError
        @feed = [{"story" => "Error Parsing Facebook Feed", "created_time" => Time.now+1.minute}]
      rescue Koala::Facebook::AuthenticationError
        @feed = [{"story" => "Error Parsing Facebook Feed", "created_time" => Time.now+1.minute}]
      end
      
      
      #google stuff
      @token = @user.google_oauth
      @rtoken = @user.refresh_token
      @calendar = @user.selected_calendar
      if @token.blank?
      
      else
        oauth_yaml = YAML.load_file('google-api.yaml')
        client = Google::APIClient.new
        client.authorization.client_id = oauth_yaml["client_id"]
        client.authorization.client_secret = oauth_yaml["client_secret"]
        client.authorization.scope = oauth_yaml["scope"]
        client.authorization.refresh_token = @rtoken
        client.authorization.access_token = @token
        
        if client.authorization.refresh_token && client.authorization.expired?
          client.authorization.fetch_access_token!
        end
        
        service = client.discovered_api('calendar', 'v3')
        result = client.execute(
          :api_method => service.events.list,
          #:parameters => {'calendarId' => 'primary', "timeMin" => Time.now.xmlschema},
          :parameters => {'calendarId' => 'primary'},
          :headers => {'Content-Type' => 'application/json'}
        )
        if result.blank?
          @parsed = []
        else
          @parsed = JSON.parse(result.data.to_json)
        end
      end
    end
  end
  
  def applicants
    @applicants = TenantApplication.find(:all, :order => "created_at desc")
  end
  
  def remove_announcement
    Announcement.all.each do |a|
      a.update_attribute("displayed", false)
    end
  end
  def display_announcement
    @announcement = Announcement.find(params[:id])
    @announcement.update_attribute("displayed", true)
  end
  
  def add_calendar_event
    title = params[:title]
    description = params[:description]
    event_start = params[:event_start].to_datetime
    @user = current_user
    @token = @user.google_oauth
    @rtoken = @user.refresh_token
    oauth_yaml = YAML.load_file('google-api.yaml')
    client = Google::APIClient.new
    client.authorization.client_id = oauth_yaml["client_id"]
    client.authorization.client_secret = oauth_yaml["client_secret"]
    client.authorization.scope = oauth_yaml["scope"]
    client.authorization.refresh_token = @rtoken
    client.authorization.access_token = @token
    
    if client.authorization.refresh_token && client.authorization.expired?
      client.authorization.fetch_access_token!
    end
    
    service = client.discovered_api('calendar', 'v3')
    event = {
      'summary' => title,
      'description' => description,
      'start' => {
        'dateTime' => event_start
      },
      'end' => {
        'dateTime' => event_start
      },
      'attendees' => [
        {
          'email' => @user.email
        },
      ]
    }
    insert = client.execute(
      :api_method => service.events.insert,
      :parameters => {'calendarId' => 'primary'},
      :body => JSON.dump(event),
      :headers => {'Content-Type' => 'application/json'}
    )

    @response = JSON.parse(insert.data.to_json)
  end
  
  def user_events
    if user_signed_in?
      @user = current_user
      @token = @user.google_oauth
      @rtoken = @user.refresh_token
      guser = User.find(10)
      gtoken = guser.google_oauth
      grtoken = guser.refresh_token
            
      @acre_events = Event.all
      @grants = Grant.where("publish = ?", true)
      @acre_events.each do |a|
        ue = @user.user_events.find_by_origin_and_origin_id("event", a.id)
        if ue.blank?
          if a.event_image_file_name.blank?
            nue = UserEvent.create(:phone => a.phone, :website => a.website, :origin => "event", :origin_id => a.id, :event_start => a.eventdate, :event_end => a.eventenddate, :name => a.title, :content => a.content, :location => "#{a.address_line_one} __ #{a.address_line_two}", :user_id => @user.id) unless a.eventdate.blank?
          else
            nue = UserEvent.create(:user_event_image => File.new(a.event_image.path, "r"), :phone => a.phone, :website => a.website, :origin => "event", :origin_id => a.id, :event_start => a.eventdate, :event_end => a.eventenddate, :name => a.title, :content => a.content, :location => "#{a.address_line_one} __ #{a.address_line_two}", :user_id => @user.id) unless a.eventdate.blank?
          end
        elsif a.updated_at > ue.updated_at
          if a.event_image_file_name.blank?
            ue.update_attributes(:phone => a.phone, :website => a.website, :event_start => a.eventdate, :event_end => a.eventenddate, :name => a.title, :content => a.content, :location => "#{a.address_line_one} __ #{a.address_line_two}", :user_id => @user.id) unless a.eventdate.blank?
            ue.save
          else
            ue.update_attributes(:user_event_image => File.new(a.event_image.path, "r"), :phone => a.phone, :website => a.website, :event_start => a.eventdate, :event_end => a.eventenddate, :name => a.title, :content => a.content, :location => "#{a.address_line_one} __ #{a.address_line_two}", :user_id => @user.id) unless a.eventdate.blank?
            ue.save
          end
        end
  
      end
      @grants.each do |g|
        ue = @user.user_events.find_by_origin_and_origin_id("grant", g.id)
        if ue.blank?
          UserEvent.create(:origin => "grant", :origin_id => g.id, :event_start => g.due_date, :event_end => g.due_date, :name => g.name, :content => g.description, :user_id => @user.id) unless g.due_date.blank?
        elsif g.updated_at > ue.updated_at
          ue.update_attributes(:event_start => g.due_date, :event_end => g.due_date, :name => g.name, :content => g.description) unless g.due_date.blank?
          ue.save
        end
  
      end
        
      unless @token.blank?
        oauth_yaml = YAML.load_file('google-api.yaml')
        client = Google::APIClient.new
        client.authorization.client_id = oauth_yaml["client_id"]
        client.authorization.client_secret = oauth_yaml["client_secret"]
        client.authorization.scope = oauth_yaml["scope"]
        client.authorization.refresh_token = @rtoken
        client.authorization.access_token = @token
        
        if client.authorization.refresh_token && client.authorization.expired?
          client.authorization.fetch_access_token!
        end
        
        service = client.discovered_api('calendar', 'v3')
        result = client.execute(
          :api_method => service.events.list,
          #:parameters => {'calendarId' => 'primary', "timeMin" => Time.now.xmlschema},
          :parameters => {'calendarId' => 'primary'},
          :headers => {'Content-Type' => 'application/json'}
        )
        if result.blank?
          @parsed = []
        else
          @parsed = JSON.parse(result.data.to_json)
        end
        unless @parsed["items"].nil?
          @parsed["items"].each do |i|
            ue = @user.user_events.find_by_origin_and_google_id("google", i["id"])
            if ue.blank?
              unless i["start"].blank?
                UserEvent.create(:google_link => i["htmlLink"], :origin => "google", :origin_id => i["id"], :google_id => i["id"], :event_start => i["start"]["date"].blank? ? i["start"]["dateTime"] : i["start"]["date"], :event_end => i["end"]["date"].blank? ? i["end"]["dateTime"] : i["end"]["date"], :name => i["summary"], :content => i["description"], :location => i["location"], :user_id => @user.id) unless (i["start"]["date"].blank? && i["start"]["dateTime"].blank?)
              end
            elsif i["updated"].to_datetime > ue.updated_at
              unless i["start"].blank?
                ue.update_attributes(:google_link => i["htmlLink"], :event_start => i["start"]["date"].blank? ? i["start"]["dateTime"] : i["start"]["date"], :event_end => i["end"]["date"].blank? ? i["end"]["dateTime"] : i["end"]["date"], :name => i["summary"], :content => i["description"], :location => i["location"]) unless (i["start"]["date"].blank? && i["start"]["dateTime"].blank?)
                ue.save
              end
            end
          end
        end
      end
      
      unless gtoken.blank?
        goauth_yaml = YAML.load_file('google-api.yaml')
        gclient = Google::APIClient.new
        gclient.authorization.client_id = goauth_yaml["client_id"]
        gclient.authorization.client_secret = goauth_yaml["client_secret"]
        gclient.authorization.scope = goauth_yaml["scope"]
        gclient.authorization.refresh_token = grtoken
        gclient.authorization.access_token = gtoken
        
        if gclient.authorization.refresh_token && gclient.authorization.expired?
          gclient.authorization.fetch_access_token!
        end
        
        gservice = gclient.discovered_api('calendar', 'v3')
        gresult = gclient.execute(
          :api_method => gservice.events.list,
          #:parameters => {'calendarId' => 'primary', "timeMin" => Time.now.xmlschema},
          :parameters => {'calendarId' => 'primary'},
          :headers => {'Content-Type' => 'application/json'}
        )
    
        gitems = JSON.parse(gresult.data.to_json)["items"]
      end
      
      unless gtoken.blank?
        gitems.each do |i|
          gue = @user.user_events.find_by_origin_and_google_id("acregoogle", i["id"])
          if gue.blank?
            unless i["start"].blank?
              UserEvent.create(:origin => "acregoogle", :origin_id => i["id"], :google_id => i["id"], :event_start => i["start"]["date"].blank? ? i["start"]["dateTime"] : i["start"]["date"], :event_end => i["end"]["date"].blank? ? i["end"]["dateTime"] : i["end"]["date"], :name => i["summary"], :content => i["description"], :location => i["location"], :user_id => @user.id) unless (i["start"]["date"].blank? && i["start"]["dateTime"].blank?)
            end
          elsif i["updated"].to_datetime > gue.updated_at
            unless i["start"].blank?
              gue.update_attributes(:event_start => i["start"]["date"].blank? ? i["start"]["dateTime"] : i["start"]["date"], :event_end => i["end"]["date"].blank? ? i["end"]["dateTime"] : i["end"]["date"], :name => i["summary"], :content => i["description"], :location => i["location"]) unless (i["start"]["date"].blank? && i["start"]["dateTime"].blank?)
              gue.save
            end
          end
        end
      end
      
    end
  end
  
  def delete_image
    thing = params[:thing]
    id = params[:id]
    case thing
    when "event"
      Event.find(id).event_image.destroy
      Event.find(id).event_image.clear
      Event.find(id).update_attribute("event_image_file_name", nil)
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin administration"
  end
  
  def set_resources
    @provider = Provider.new
    @resume = Resume.new
    @tool = Tool.new
    @news_site = NewsSite.new
    @event = Event.new
    @grant = Grant.new
    @resume_specialty_options = ResumeSpecialtyOption.all
    @provider_specialty_options = ProviderSpecialtyOption.all
    @tool_specialty_options = ToolSpecialtyOption.all
    @news_site_specialty_options = NewsSiteSpecialtyOption.all
  end
  
end

