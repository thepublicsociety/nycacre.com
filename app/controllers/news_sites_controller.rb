class NewsSitesController < ApplicationController
  load_and_authorize_resource
  before_filter :set_class
  # GET /news_sites
  # GET /news_sites.json
  def index
    @news_sites = NewsSite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news_sites }
    end
  end

  # GET /news_sites/1
  # GET /news_sites/1.json
  def show
    @news_site = NewsSite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news_site }
    end
  end

  # GET /news_sites/new
  # GET /news_sites/new.json
  def new
    @news_site = NewsSite.new
    @tenants = Tenant.find(:all, :conditions => ["publish=? and lower(name) !=?", true, "acre"], :order => "name ASC")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news_site }
    end
  end

  # GET /news_sites/1/edit
  def edit
    @news_site = NewsSite.find(params[:id])
    @tenants = Tenant.find(:all, :conditions => ["publish=? and lower(name) !=?", true, "acre"], :order => "name ASC")
  end

  # POST /news_sites
  # POST /news_sites.json
  def create
    @news_site = NewsSite.new(params[:news_site])

    respond_to do |format|
      if @news_site.save
        format.html { redirect_to news_sites_url, notice: 'News site was successfully created.' }
        format.js {  }
        format.json { render json: @news_site, status: :created, location: @news_site }
      else
        format.html { render action: "new" }
        format.json { render json: @news_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news_sites/1
  # PUT /news_sites/1.json
  def update
    @news_site = NewsSite.find(params[:id])

    respond_to do |format|
      if @news_site.update_attributes(params[:news_site])
        format.html { redirect_to news_sites_url, notice: 'News site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_sites/1
  # DELETE /news_sites/1.json
  def destroy
    @news_site = NewsSite.find(params[:id])
    @news_site.destroy

    respond_to do |format|
      format.html { redirect_to news_sites_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin_news_sites"
  end
end
