class NewsSiteSpecialtyOptionsController < ApplicationController
  # GET /news_site_specialty_options
  # GET /news_site_specialty_options.json
  def index
    @news_site_specialty_options = NewsSiteSpecialtyOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news_site_specialty_options }
    end
  end

  # GET /news_site_specialty_options/1
  # GET /news_site_specialty_options/1.json
  def show
    @news_site_specialty_option = NewsSiteSpecialtyOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news_site_specialty_option }
    end
  end

  # GET /news_site_specialty_options/new
  # GET /news_site_specialty_options/new.json
  def new
    @news_site_specialty_option = NewsSiteSpecialtyOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news_site_specialty_option }
    end
  end

  # GET /news_site_specialty_options/1/edit
  def edit
    @news_site_specialty_option = NewsSiteSpecialtyOption.find(params[:id])
  end

  # POST /news_site_specialty_options
  # POST /news_site_specialty_options.json
  def create
    @news_site_specialty_option = NewsSiteSpecialtyOption.new(params[:news_site_specialty_option])

    respond_to do |format|
      if @news_site_specialty_option.save
        format.html { redirect_to snippets_path, notice: 'News site specialty option was successfully created.' }
        format.json { render json: @news_site_specialty_option, status: :created, location: @news_site_specialty_option }
      else
        format.html { render action: "new" }
        format.json { render json: @news_site_specialty_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news_site_specialty_options/1
  # PUT /news_site_specialty_options/1.json
  def update
    @news_site_specialty_option = NewsSiteSpecialtyOption.find(params[:id])

    respond_to do |format|
      if @news_site_specialty_option.update_attributes(params[:news_site_specialty_option])
        format.html { redirect_to snippets_path, notice: 'News site specialty option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news_site_specialty_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_site_specialty_options/1
  # DELETE /news_site_specialty_options/1.json
  def destroy
    @news_site_specialty_option = NewsSiteSpecialtyOption.find(params[:id])
    @news_site_specialty_option.destroy

    respond_to do |format|
      format.html { redirect_to news_site_specialty_options_url }
      format.json { head :no_content }
    end
  end
end
