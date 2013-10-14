class PostsController < ApplicationController
  load_and_authorize_resource
  before_filter :set_class
  load_and_authorize_resource
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    @tenants = Tenant.find(:all, :order => "name ASC")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @tenants = Tenant.find(:all, :order => "name ASC")
  end

  # POST /posts
  # POST /posts.xml
  def create
    
    if params[:post][:category] == "newsletter" || params[:post][:title].include?("newsletter")
      title = params[:post][:title].gsub(/ /, "_")
      FileUtils.mkdir_p("#{Rails.root.to_s}/public/#{title}")
      html = params[:post][:content]
      doc = Nokogiri::HTML(html)
      doc.css("img").each do |img|
        src = img["src"]
        filename = File.basename(src)
        #File.open("#{Rails.root.to_s}/public/#{title}/#{filename}", 'wb'){|f| f.write(open(src).read)}
        system %x{wget -O "#{Rails.root.to_s}/public/#{title}/#{filename}" #{src}}
        img['src'] = "/#{title}/#{filename}"
      end
      params[:post][:content] = doc.to_html
    end
    
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(posts_path, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(posts_path, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin_posts"
  end
end
