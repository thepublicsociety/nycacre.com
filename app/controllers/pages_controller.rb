class PagesController < ApplicationController
  require 'rubygems'
  require 'google/api_client'
  require 'yaml'
  require 'truncate_html'
  before_filter :calendar_events, :except => :calendar
  def index
    @user = current_user
    @current_announcement = Announcement.where("displayed = ?", true).last
    unless @current_announcement.blank?
      bg = Background.find_by_page_controller_and_page_action("pages", "announcement")
      @bgimg = bg.background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    else
      bg = Background.find_by_page_controller_and_page_action("pages", "index")
      @bgimg = bg.background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    end
    @news = Post.find(:all, :conditions => ["publish=? and archive=? and internal_only=?", true, false, false], :order => "created_at DESC", :limit => 7)
    @acre = Acre.where("featured=?", true).blank? ? Acre.all.last : Acre.where("featured=?", true).last
    
    client = Twitter::Client.new(
      :consumer_key => "VmUFzBCk13ivJADuDKLeSA",
      :consumer_secret => "6qitbysxpmXzWlRE9qsmFuIGOiZu8H5UnEvusUbw",
      :oauth_token => "1245456781-FNLCiQW279Bus9DERsqeIkt0IOf3lH8fKcSMVe2",
      :oauth_token_secret => "aE63mTy0dv09G8Ifu7YCVA1pTZDIpgePqVoMMOMK92I"
    )
    @tweets = client.user_timeline("nycacre", :count => 2)
    @statement = Statement.where("publish=?", true).order("created_at desc").first
  end
  def map
    @user = current_user
    bg = Background.find_by_page_controller_and_page_action("pages", "index")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @news = Post.find(:all, :conditions => ["publish=? and archive=? and internal_only=?", true, false, false], :order => "created_at DESC", :limit => 5)
    @acre = Acre.where("featured=?", true).blank? ? Acre.all.last : Acre.where("featured=?", true).last
    @events = Event.find(:all, :order => "eventdate ASC", :limit => 3)
    client = Twitter::Client.new(
      :consumer_key => "VmUFzBCk13ivJADuDKLeSA",
      :consumer_secret => "6qitbysxpmXzWlRE9qsmFuIGOiZu8H5UnEvusUbw",
      :oauth_token => "1245456781-FNLCiQW279Bus9DERsqeIkt0IOf3lH8fKcSMVe2",
      :oauth_token_secret => "aE63mTy0dv09G8Ifu7YCVA1pTZDIpgePqVoMMOMK92I"
    )
    @tweets = client.user_timeline("nycacre", :count => 2)
  end
  def challenge
    @user = current_user
    bg = Background.find_by_page_controller_and_page_action("pages", "challenge")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @news = Post.find(:all, :conditions => ["publish=? and tag like ? and archive=? and internal_only=?", true, "%challenge%", false, false], :order => "created_at DESC", :limit => 3)
    @articles = Article.find(:all, :conditions => ["publish=? and tag like ?", true, "%challenge%"], :order => "created_at DESC", :limit => 5)
    
    @challenge = Challenge.where("featured=?", true).blank? ? Challenge.all.last : Challenge.where("featured=?", true).last
  end
  def about
    @user = current_user
    bg = Background.find_by_page_controller_and_page_action("pages", "about")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @tenant = Tenant.where("lower(name)=?", "ACRE".downcase).first
    
    @tenants = Tenant.find(:all, :conditions => ["active=? and lower(name) !=?", true, "acre"], :order => "name ASC")
    @graduates = Graduate.find(:all, :order => "name asc")
    @news = Post.find(:all, :conditions => ["publish=? and archive=? and internal_only=?", true, false, false], :order => "created_at DESC", :limit => 7)
    client = Twitter::Client.new(
      :consumer_key => "VmUFzBCk13ivJADuDKLeSA",
      :consumer_secret => "6qitbysxpmXzWlRE9qsmFuIGOiZu8H5UnEvusUbw",
      :oauth_token => "1245456781-FNLCiQW279Bus9DERsqeIkt0IOf3lH8fKcSMVe2",
      :oauth_token_secret => "aE63mTy0dv09G8Ifu7YCVA1pTZDIpgePqVoMMOMK92I"
    )
    @tweets = client.user_timeline("nycacre", :count => 5)
    @advisors = Advisor.all
  end
  def about_tenant
    @user = current_user
    @tenant = Tenant.find_by_name(params[:tenant])
    
    if Background.find_by_page_controller_and_page_action("pages", @tenant.name).blank?
      bg = Background.find_by_page_controller_and_page_action("pages", "about_tenant")
      @bgimg = bg.background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    else
      bg = Background.find_by_page_controller_and_page_action("pages", @tenant.name)
      @bgimg = bg.background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    end
    
    @tenants = Tenant.find(:all, :conditions => ["active=? and lower(name) !=?", true, "acre"], :order => "name ASC")
    @graduates = Graduate.find(:all, :order => "name asc")
    @news = Post.find(:all, :conditions => ["publish=? and archive=? and tenant like ? and internal_only=?", true, false, "%#{@tenant.name}%", false], :order => "created_at DESC", :limit => 7).empty? ? Post.find(:all, :conditions => ["publish=? and archive=? and internal_only=?", true, false, false], :order => "created_at DESC", :limit => 7) : Post.find(:all, :conditions => ["publish=? and archive=? and tenant like ? and internal_only=?", true, false, "%#{@tenant.name}%", false], :order => "created_at DESC", :limit => 7)
    client = Twitter::Client.new(
      :consumer_key => "VmUFzBCk13ivJADuDKLeSA",
      :consumer_secret => "6qitbysxpmXzWlRE9qsmFuIGOiZu8H5UnEvusUbw",
      :oauth_token => "1245456781-FNLCiQW279Bus9DERsqeIkt0IOf3lH8fKcSMVe2",
      :oauth_token_secret => "aE63mTy0dv09G8Ifu7YCVA1pTZDIpgePqVoMMOMK92I"
    )
    @twitter_handle = @tenant.twitter_link.blank? ? "nycacre" : @tenant.twitter_link.gsub(/.*com\//, "")
    @tweets = client.user_timeline("#{@twitter_handle.blank? ? "nycacre" : @twitter_handle}", :count => 5)
  end
  def graduate
    @user = current_user
    @graduate = Graduate.find_by_name(params[:graduate])
    if Background.find_by_page_controller_and_page_action("pages", @graduate.name).blank?
      bg = Background.find_by_page_controller_and_page_action("pages", "graduate")
      @bgimg = bg.background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    else
      bg = Background.find_by_page_controller_and_page_action("pages", @graduate.name)
      @bgimg = bg.background_image.url
      @bgheight = bg.height.to_i
      @bgwidth = bg.width.to_i
    end
    @tenants = Tenant.find(:all, :conditions => ["active=? and name !=?", true, "acre"], :order => "name ASC")
    @graduates = Graduate.find(:all, :order => "name asc")
  end
  def news
    @user = current_user
    bg = Background.find_by_page_controller_and_page_action("pages", "news")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    
    #@otherevents = Event.find(:all, :order => "eventdate ASC", :limit => 3)
    client = Twitter::Client.new(
      :consumer_key => "VmUFzBCk13ivJADuDKLeSA",
      :consumer_secret => "6qitbysxpmXzWlRE9qsmFuIGOiZu8H5UnEvusUbw",
      :oauth_token => "1245456781-FNLCiQW279Bus9DERsqeIkt0IOf3lH8fKcSMVe2",
      :oauth_token_secret => "aE63mTy0dv09G8Ifu7YCVA1pTZDIpgePqVoMMOMK92I"
    )
    tweet1 = client.user_timeline("nycacre", :count => 2)
    tweet2 = client.search("#nycacre", :count => 2).statuses
    @tweets = tweet1 + tweet2
    @news = Post.paginate(:conditions => ["publish=? and featured=? and archive=? and internal_only=?", true, false, false, false], :order => "created_at DESC", :per_page => 5, :page => params[:page])
    @features = Post.find(:all, :conditions => ["publish=? and featured=? and archive=? and internal_only=?", true, true, false, false], :order => "created_at DESC", :limit => 2)
  end
  def search
    query = params[:query]
    @search_results = Post.where("title like ? or author like ? or content like ? or tag like ? or category like ? or subheading like ? and internal_only=?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", false).order("created_at desc")
  end
  def news_article
    @user = current_user
    bg = Background.find_by_page_controller_and_page_action("pages", "news_article")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @post = Post.find_by_title(params[:title]).blank? ? Post.where("title like ?", "%#{params[:title]}%").first : Post.find_by_title(params[:title])
    
    #@otherevents = Event.find(:all, :order => "eventdate ASC", :limit => 3)
    client = Twitter::Client.new(
      :consumer_key => "VmUFzBCk13ivJADuDKLeSA",
      :consumer_secret => "6qitbysxpmXzWlRE9qsmFuIGOiZu8H5UnEvusUbw",
      :oauth_token => "1245456781-FNLCiQW279Bus9DERsqeIkt0IOf3lH8fKcSMVe2",
      :oauth_token_secret => "aE63mTy0dv09G8Ifu7YCVA1pTZDIpgePqVoMMOMK92I"
    )
    tweet1 = client.user_timeline("nycacre", :count => 1)
    tweet2 = client.search("#nycacre", :count => 1).statuses
    @tweets = tweet1 + tweet2
    category = @post.category
    tags = @post.tag.split(",").collect(&:strip)
    @related = []
    @further = []
    Post.where("category = ? and internal_only=?", category, false).each do |p|
      @related.push(p) unless @post.id == p.id
    end
    Article.where("category = ?", category).each do |a|
      @further.push(a)
    end
    tags.each do |t|
      Post.where("tag like ? and internal_only=?", "%#{t}%", false).each do |p|
        @related.push(p) unless @post.id == p.id
      end
      Article.where("tag like ?", "%#{t}%").each do |a|
        @further.push(a)
      end
    end
    @related = @related.uniq.take(4)
    @further = @further.uniq.take(4)
  end
  def article
    @user = current_user
    @bgimg = Background.find_by_page_controller_and_page_action("pages", "article").background_image.url
    @bgheight = Paperclip::Geometry.from_file(Background.find_by_page_controller_and_page_action("pages", "article").background_image.path).height.to_i
    @bgwidth = Paperclip::Geometry.from_file(Background.find_by_page_controller_and_page_action("pages", "article").background_image.path).width.to_i
    @article = Article.find_by_title(params[:title])
    
    #@otherevents = Event.find(:all, :order => "eventdate ASC", :limit => 3)
    client = Twitter::Client.new(
      :consumer_key => "VmUFzBCk13ivJADuDKLeSA",
      :consumer_secret => "6qitbysxpmXzWlRE9qsmFuIGOiZu8H5UnEvusUbw",
      :oauth_token => "1245456781-FNLCiQW279Bus9DERsqeIkt0IOf3lH8fKcSMVe2",
      :oauth_token_secret => "aE63mTy0dv09G8Ifu7YCVA1pTZDIpgePqVoMMOMK92I"
    )
    tweet1 = client.user_timeline("nycacre", :count => 1)
    tweet2 = client.search("#nycacre", :count => 1).statuses
    @tweets = tweet1 + tweet2
    category = @article.category
    tags = @article.tag.split(",").collect(&:strip)
    @related = []
    @further = []
    Post.where("category = ? and internal_only=?", category, false).each do |p|
      @related.push(p)
    end
    Article.where("category = ?", category).each do |a|
      @further.push(a) unless @article.id == a.id
    end
    tags.each do |t|
      Post.where("tag like ? and internal_only=?", "%#{t}%", false).each do |p|
        @related.push(p)
      end
      Article.where("tag like ?", "%#{t}%").each do |a|
        @further.push(a) unless @article.id == a.id
      end
    end
    @related = @related.uniq.take(4)
    @further = @further.uniq.take(4)
  end
  def contact
    @user = current_user
    bg = Background.find_by_page_controller_and_page_action("pages", "contact")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @apply_text = Snippet.find(3)
    @newsletter = Subscription.new
    @resume = Resume.new
    @tenant_application = TenantApplication.new
    @tenants = Tenant.find(:all, :conditions => ["active=? and email <> ''", true], :order => "name ASC")
    @graduates = Graduate.find(:all, :conditions => ["publish=? and email <> ''", true], :order => "name ASC")
    @emailers = @tenants + @graduates
    @message = Message.new
    @resume_specialty_options = ResumeSpecialtyOption.all
    @funding_status_options = FundingStatusOption.all
    @jobs = JobPosting.find(:all, :joins => :tenant, :conditions => ["job_postings.publish = ?", true], :order => "tenants.name asc")
    unless params[:job].blank?
      @job = JobPosting.find(params[:job])
    end
  end
  def calendar
    @user = current_user
    bg = Background.find_by_page_controller_and_page_action("pages", "calendar")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @events = Event.find(:all, :order => "eventdate ASC")
    
    #google calendar
    guser = User.find(10)
    token = guser.google_oauth
    rtoken = guser.refresh_token

    unless token.blank?
      oauth_yaml = YAML.load_file('google-api.yaml')
      client = Google::APIClient.new
      client.authorization.client_id = oauth_yaml["client_id"]
      client.authorization.client_secret = oauth_yaml["client_secret"]
      client.authorization.scope = oauth_yaml["scope"]
      client.authorization.refresh_token = rtoken
      client.authorization.access_token = token
      
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
  
      items = JSON.parse(result.data.to_json)["items"]
    end
    
    @events.each do |e|
      ce = CalendarEvent.find_by_origin_and_origin_id("event", e.id)
      if ce.blank?
        nce = CalendarEvent.create(:phone => e.phone, :website => e.website, :origin => "event", :origin_id => e.id, :event_start => e.eventdate, :event_end => e.eventenddate, :name => e.title, :description => e.content, :location => "#{e.address_line_one} __ #{e.address_line_two}") unless e.eventdate.blank?
      elsif e.updated_at > ce.updated_at
        ce.update_attributes(:phone => e.phone, :website => e.website, :event_start => e.eventdate, :event_end => e.eventenddate, :name => e.title, :description => e.content, :location => "#{e.address_line_one} __ #{e.address_line_two}") unless e.eventdate.blank?
        ce.save
      end
    end
    
    unless token.blank?
      items.each do |i|
        ce = CalendarEvent.find_by_origin_and_google_id("acregoogle", i["id"])
        if ce.blank?
          unless i["start"].blank?
            CalendarEvent.create(:origin => "acregoogle", :google_id => i["id"], :event_start => i["start"]["date"].blank? ? i["start"]["dateTime"] : i["start"]["date"], :event_end => i["end"]["date"].blank? ? i["end"]["dateTime"] : i["end"]["date"], :name => i["summary"], :description => i["description"], :location => i["location"]) unless (i["start"]["date"].blank? && i["start"]["dateTime"].blank?)
          end
        elsif i["updated"].to_datetime > ce.updated_at
          unless i["start"].blank?
            ce.update_attributes(:event_start => i["start"]["date"].blank? ? i["start"]["dateTime"] : i["start"]["date"], :event_end => i["end"]["date"].blank? ? i["end"]["dateTime"] : i["end"]["date"], :name => i["summary"], :description => i["description"], :location => i["location"]) unless (i["start"]["date"].blank? && i["start"]["dateTime"].blank?)
            ce.save
          end
        end
      end
    end
    
    @calendar_events = CalendarEvent.all
    
  end
  
  def send_email_form
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
  	redirect_to "/contact"
  end
  
  def announcement
    @user = current_user
    bg = Background.find_by_page_controller_and_page_action("pages", "announcement")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @announcement = Announcement.find(params[:id])
    
    #@otherevents = Event.find(:all, :order => "eventdate ASC", :limit => 3)
    client = Twitter::Client.new(
      :consumer_key => "VmUFzBCk13ivJADuDKLeSA",
      :consumer_secret => "6qitbysxpmXzWlRE9qsmFuIGOiZu8H5UnEvusUbw",
      :oauth_token => "1245456781-FNLCiQW279Bus9DERsqeIkt0IOf3lH8fKcSMVe2",
      :oauth_token_secret => "aE63mTy0dv09G8Ifu7YCVA1pTZDIpgePqVoMMOMK92I"
    )
    tweet1 = client.user_timeline("nycacre", :count => 1)
    tweet2 = client.search("#nycacre", :count => 1).statuses
    @tweets = tweet1 + tweet2
  end
  
  def event_display
    @event = UserEvent.find(params[:id])
    @user = current_user ||= User.new
    bg = Background.find_by_page_controller_and_page_action("pages", "calendar")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc")
    begin
      #"BAACEdEose0cBAMhRLI0fDVQb53PPZB64EPqlOSBS86d7Lbuf2sFnemmjJCDN23LXuVo04ZAffSLyOHmU8dnanjhWJrohw6snLWmRJoRBXWjfRsDNWaAk1He9lyvXPWRh4G1ZAy7vnUiJNb6AzDnhpyaEP2lLb7QKtsRzP6ZAPD8ZBTKDMTFBl7KP76REvWnR4ZCXFO2fOBoVJLtBXTBSYUTWa7mr4GG6TfTNFmEb4OggZDZD"
      fb_token = FacebookUser.first.token
      @graph = Koala::Facebook::API.new(fb_token)
      @feed = @graph.get_connections("me", "feed")[0..2]
    rescue Koala::Facebook::APIError
      @feed = [{"story" => "Error Parsing Facebook Feed", "created_time" => Time.now+1.minute}]
    end
  end
  
  def grant_display
    @event = UserEvent.find(params[:id])
    @resource = Grant.find(@event.origin_id)
    @user = current_user ||= User.new
#    @bgimg = Background.find_by_page_controller_and_page_action("administration", "calendar").background_image.url
#    @bgheight = Paperclip::Geometry.from_file(Background.find_by_page_controller_and_page_action("administration", "calendar").background_image.path).height.to_i
#    @bgwidth = Paperclip::Geometry.from_file(Background.find_by_page_controller_and_page_action("administration", "calendar").background_image.path).width.to_i
    @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc")
    begin
      #"BAACEdEose0cBAMhRLI0fDVQb53PPZB64EPqlOSBS86d7Lbuf2sFnemmjJCDN23LXuVo04ZAffSLyOHmU8dnanjhWJrohw6snLWmRJoRBXWjfRsDNWaAk1He9lyvXPWRh4G1ZAy7vnUiJNb6AzDnhpyaEP2lLb7QKtsRzP6ZAPD8ZBTKDMTFBl7KP76REvWnR4ZCXFO2fOBoVJLtBXTBSYUTWa7mr4GG6TfTNFmEb4OggZDZD"
      fb_token = FacebookUser.first.token
      @graph = Koala::Facebook::API.new(fb_token)
      @feed = @graph.get_connections("me", "feed")[0..2]
    rescue Koala::Facebook::APIError
      @feed = [{"story" => "Error Parsing Facebook Feed", "created_time" => Time.now+1.minute}]
    end
    
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
    @providers = Provider.where("publish=?", true)
    @grants = Grant.where("publish=?", true)
    @resumes = Resume.all
    @tools = Tool.where("publish=?", true)
    @news = NewsSite.where("publish=?", true)
    @recent_providers = Provider.where("publish=? and created_at > ?", true, 5.days.ago)
    @recent_grants = Grant.where("publish=? and created_at > ?", true, 5.days.ago)
    @recent_resumes = Resume.where("created_at > ?", 5.days.ago)
    @recent_tools = Tool.where("publish=? and created_at > ?", true, 5.days.ago)
    @recent_news = NewsSite.where("publish=? and created_at > ?", true, 5.days.ago)
    @specialty_providers = @providers.group_by {|p| p.specialty}
    @specialty_resumes = @resumes.group_by {|r| r.specialty}
    @specialty_grants = @grants.group_by {|g| g.specialty}
    @specialty_tools = @tools.group_by {|c| c.specialty}
    @specialty_news = @news.group_by {|n| n.specialty}
    @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc")
    @provider = Provider.new
    @resume = Resume.new
    @tool = Tool.new
    @news_site = NewsSite.new
    @event = Event.new
    @grant = Grant.new
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
  end
  
  def google_event_display
    @event = UserEvent.find(params[:id])
    @user = current_user ||= User.new
    bg = Background.find_by_page_controller_and_page_action("administration", "calendar")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc")
    begin
      #"BAACEdEose0cBAMhRLI0fDVQb53PPZB64EPqlOSBS86d7Lbuf2sFnemmjJCDN23LXuVo04ZAffSLyOHmU8dnanjhWJrohw6snLWmRJoRBXWjfRsDNWaAk1He9lyvXPWRh4G1ZAy7vnUiJNb6AzDnhpyaEP2lLb7QKtsRzP6ZAPD8ZBTKDMTFBl7KP76REvWnR4ZCXFO2fOBoVJLtBXTBSYUTWa7mr4GG6TfTNFmEb4OggZDZD"
      fb_token = FacebookUser.first.token
      @graph = Koala::Facebook::API.new(fb_token)
      @feed = @graph.get_connections("me", "feed")[0..2]
    rescue Koala::Facebook::APIError
      @feed = [{"story" => "Error Parsing Facebook Feed", "created_time" => Time.now+1.minute}]
    end
    
  end
  
  def cal_event_display
    @event = CalendarEvent.find(params[:id])
    @resource = Event.find(@event.origin_id)
    @user = current_user ||= User.new
    bg = Background.find_by_page_controller_and_page_action("pages", "calendar")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc")
    begin
      #"BAACEdEose0cBAMhRLI0fDVQb53PPZB64EPqlOSBS86d7Lbuf2sFnemmjJCDN23LXuVo04ZAffSLyOHmU8dnanjhWJrohw6snLWmRJoRBXWjfRsDNWaAk1He9lyvXPWRh4G1ZAy7vnUiJNb6AzDnhpyaEP2lLb7QKtsRzP6ZAPD8ZBTKDMTFBl7KP76REvWnR4ZCXFO2fOBoVJLtBXTBSYUTWa7mr4GG6TfTNFmEb4OggZDZD"
      fb_token = FacebookUser.first.token
      @graph = Koala::Facebook::API.new(fb_token)
      @feed = @graph.get_connections("me", "feed")[0..2]
    rescue Koala::Facebook::APIError
      @feed = [{"story" => "Error Parsing Facebook Feed", "created_time" => Time.now+1.minute}]
    end
    
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
    @providers = Provider.where("publish=?", true)
    @grants = Grant.where("publish=?", true)
    @resumes = Resume.all
    @tools = Tool.where("publish=?", true)
    @news = NewsSite.where("publish=?", true)
    @recent_providers = Provider.where("publish=? and created_at > ?", true, 5.days.ago)
    @recent_grants = Grant.where("publish=? and created_at > ?", true, 5.days.ago)
    @recent_resumes = Resume.where("created_at > ?", 5.days.ago)
    @recent_tools = Tool.where("publish=? and created_at > ?", true, 5.days.ago)
    @recent_news = NewsSite.where("publish=? and created_at > ?", true, 5.days.ago)
    @specialty_providers = @providers.group_by {|p| p.specialty}
    @specialty_resumes = @resumes.group_by {|r| r.specialty}
    @specialty_grants = @grants.group_by {|g| g.specialty}
    @specialty_tools = @tools.group_by {|c| c.specialty}
    @specialty_news = @news.group_by {|n| n.specialty}
    @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc")
    @provider = Provider.new
    @resume = Resume.new
    @tool = Tool.new
    @news_site = NewsSite.new
    #@event = Event.new
    @grant = Grant.new
    @related =  []
    #Grant.where("specialty like ? or category like ? or sector like ?", "%#{@resource.specialty}%", "%#{@resource.category}%", "%#{@resource.sector}%").each do |r|
    #  @related.push(r)
    #end
    #unless @resource.tag.blank?
    #  @resource.tag.split(",").collect(&:strip).each do |t|
    #    Grant.where("tag like ?", "%#{t}%").each do |r|
    #      @related.push(r)
    #    end
    #  end
    #end
    #unless @resource.tenant.blank?
    #  @resource.tenant.split(",").collect(&:strip).each do |t|
    #    Grant.where("tenant like ?", "%#{t}%").each do |r|
    #      @related.push(r)
    #    end
    #  end
    #end
    #@related = @related.uniq
  end
  
  def cal_grant_display
    @event = CalendarEvent.find(params[:id])
    @resource = Grant.find(@event.origin_id)
    @user = current_user ||= User.new
    bg = Background.find_by_page_controller_and_page_action("pages", "calendar")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc")
    begin
      #"BAACEdEose0cBAMhRLI0fDVQb53PPZB64EPqlOSBS86d7Lbuf2sFnemmjJCDN23LXuVo04ZAffSLyOHmU8dnanjhWJrohw6snLWmRJoRBXWjfRsDNWaAk1He9lyvXPWRh4G1ZAy7vnUiJNb6AzDnhpyaEP2lLb7QKtsRzP6ZAPD8ZBTKDMTFBl7KP76REvWnR4ZCXFO2fOBoVJLtBXTBSYUTWa7mr4GG6TfTNFmEb4OggZDZD"
      fb_token = FacebookUser.first.token
      @graph = Koala::Facebook::API.new(fb_token)
      @feed = @graph.get_connections("me", "feed")[0..2]
    rescue Koala::Facebook::APIError
      @feed = [{"story" => "Error Parsing Facebook Feed", "created_time" => Time.now+1.minute}]
    end
    
  end
  
  def cal_google_event_display
    @event = CalendarEvent.find(params[:id])
    @user = current_user ||= User.new
    bg = Background.find_by_page_controller_and_page_action("pages", "calendar")
    @bgimg = bg.background_image.url
    @bgheight = bg.height.to_i
    @bgwidth = bg.width.to_i
    @uevents = @user.user_events.where("event_start > ?", Time.now).order("event_start asc")
    begin
      #"BAACEdEose0cBAMhRLI0fDVQb53PPZB64EPqlOSBS86d7Lbuf2sFnemmjJCDN23LXuVo04ZAffSLyOHmU8dnanjhWJrohw6snLWmRJoRBXWjfRsDNWaAk1He9lyvXPWRh4G1ZAy7vnUiJNb6AzDnhpyaEP2lLb7QKtsRzP6ZAPD8ZBTKDMTFBl7KP76REvWnR4ZCXFO2fOBoVJLtBXTBSYUTWa7mr4GG6TfTNFmEb4OggZDZD"
      fb_token = FacebookUser.first.token
      @graph = Koala::Facebook::API.new(fb_token)
      @feed = @graph.get_connections("me", "feed")[0..2]
    rescue Koala::Facebook::APIError
      @feed = [{"story" => "Error Parsing Facebook Feed", "created_time" => Time.now+1.minute}]
    end
    
  end
  
  def calendar_events
    events = Event.find(:all, :order => "eventdate ASC")
    
    #google calendar
    guser = User.find(10)
    token = guser.google_oauth
    rtoken = guser.refresh_token

    unless token.blank?
      oauth_yaml = YAML.load_file('google-api.yaml')
      client = Google::APIClient.new
      client.authorization.client_id = oauth_yaml["client_id"]
      client.authorization.client_secret = oauth_yaml["client_secret"]
      client.authorization.scope = oauth_yaml["scope"]
      client.authorization.refresh_token = rtoken
      client.authorization.access_token = token
      
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
  
      items = JSON.parse(result.data.to_json)["items"]
    end
    
    events.each do |e|
      ce = CalendarEvent.find_by_origin_and_origin_id("event", e.id)
      if ce.blank?
        if e.event_image_file_name.blank?
          nce = CalendarEvent.create(:phone => e.phone, :website => e.website, :origin => "event", :origin_id => e.id, :event_start => e.eventdate, :event_end => e.eventenddate, :name => e.title, :description => e.content, :location => "#{e.address_line_one} __ #{e.address_line_two}") unless e.eventdate.blank?
        else
          nce = CalendarEvent.create(:calendar_event_image => File.new(e.event_image.path, "r"), :phone => e.phone, :website => e.website, :origin => "event", :origin_id => e.id, :event_start => e.eventdate, :event_end => e.eventenddate, :name => e.title, :description => e.content, :location => "#{e.address_line_one} __ #{e.address_line_two}") unless e.eventdate.blank?
        end
      elsif e.updated_at > ce.updated_at
        if e.event_image_file_name.blank?
          ce.update_attributes(:phone => e.phone, :website => e.website, :event_start => e.eventdate, :event_end => e.eventenddate, :name => e.title, :description => e.content, :location => "#{e.address_line_one} __ #{e.address_line_two}") unless e.eventdate.blank?
          ce.save
        else
          ce.update_attributes(:calendar_event_image => File.new(e.event_image.path, "r"), :phone => e.phone, :website => e.website, :event_start => e.eventdate, :event_end => e.eventenddate, :name => e.title, :description => e.content, :location => "#{e.address_line_one} __ #{e.address_line_two}") unless e.eventdate.blank?
          ce.save
        end
      end
    end
    
    unless token.blank?
      items.each do |i|
        ce = CalendarEvent.find_by_origin_and_google_id("acregoogle", i["id"])
        if ce.blank?
          unless i["start"].blank?
            CalendarEvent.create(:origin => "acregoogle", :google_id => i["id"], :event_start => i["start"]["date"].blank? ? i["start"]["dateTime"] : i["start"]["date"], :event_end => i["end"]["date"].blank? ? i["end"]["dateTime"] : i["end"]["date"], :name => i["summary"], :description => i["description"], :location => i["location"]) unless (i["start"]["date"].blank? && i["start"]["dateTime"].blank?)
          end
        elsif i["updated"].to_datetime > ce.updated_at
          unless i["start"].blank?
            ce.update_attributes(:event_start => i["start"]["date"].blank? ? i["start"]["dateTime"] : i["start"]["date"], :event_end => i["end"]["date"].blank? ? i["end"]["dateTime"] : i["end"]["date"], :name => i["summary"], :description => i["description"], :location => i["location"]) unless (i["start"]["date"].blank? && i["start"]["dateTime"].blank?)
            ce.save
          end
        end
      end
    end
    
    @events = CalendarEvent.where("event_start > ?", Time.now).order("event_start asc").limit(3)
  end
  
end
