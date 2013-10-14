class NewsSourcesController < ApplicationController
  load_and_authorize_resource
  before_filter :set_class
  # GET /news_sources
  # GET /news_sources.json
  def index
    @news_sources = current_user.news_sources.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news_sources }
    end
  end

  # GET /news_sources/1
  # GET /news_sources/1.json
  def show
    @news_source = NewsSource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news_source }
    end
  end

  # GET /news_sources/new
  # GET /news_sources/new.json
  def new
    @news_source = NewsSource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news_source }
    end
  end

  # GET /news_sources/1/edit
  def edit
    @news_source = NewsSource.find(params[:id])
  end

  # POST /news_sources
  # POST /news_sources.json
  def create
    @news_source = current_user.news_sources.create(params[:news_source])

    respond_to do |format|
      if @news_source.save
        format.html { redirect_to news_sources_url, notice: 'News source was successfully created.' }
        format.json { render json: @news_source, status: :created, location: @news_source }
      else
        format.html { render action: "new" }
        format.json { render json: @news_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news_sources/1
  # PUT /news_sources/1.json
  def update
    @news_source = NewsSource.find(params[:id])

    respond_to do |format|
      if @news_source.update_attributes(params[:news_source])
        format.html { redirect_to news_sources_url, notice: 'News source was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_sources/1
  # DELETE /news_sources/1.json
  def destroy
    @news_source = NewsSource.find(params[:id])
    @news_source.destroy
    current_user.feed_entries.each{|e| e.destroy}

    respond_to do |format|
      format.html { redirect_to news_sources_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin_news_sites"
  end
end
