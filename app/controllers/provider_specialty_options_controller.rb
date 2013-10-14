class ProviderSpecialtyOptionsController < ApplicationController
  # GET /provider_specialty_options
  # GET /provider_specialty_options.json
  def index
    @provider_specialty_options = ProviderSpecialtyOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @provider_specialty_options }
    end
  end

  # GET /provider_specialty_options/1
  # GET /provider_specialty_options/1.json
  def show
    @provider_specialty_option = ProviderSpecialtyOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @provider_specialty_option }
    end
  end

  # GET /provider_specialty_options/new
  # GET /provider_specialty_options/new.json
  def new
    @provider_specialty_option = ProviderSpecialtyOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @provider_specialty_option }
    end
  end

  # GET /provider_specialty_options/1/edit
  def edit
    @provider_specialty_option = ProviderSpecialtyOption.find(params[:id])
  end

  # POST /provider_specialty_options
  # POST /provider_specialty_options.json
  def create
    @provider_specialty_option = ProviderSpecialtyOption.new(params[:provider_specialty_option])

    respond_to do |format|
      if @provider_specialty_option.save
        format.html { redirect_to snippets_path, notice: 'Provider specialty option was successfully created.' }
        format.json { render json: @provider_specialty_option, status: :created, location: @provider_specialty_option }
      else
        format.html { render action: "new" }
        format.json { render json: @provider_specialty_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /provider_specialty_options/1
  # PUT /provider_specialty_options/1.json
  def update
    @provider_specialty_option = ProviderSpecialtyOption.find(params[:id])

    respond_to do |format|
      if @provider_specialty_option.update_attributes(params[:provider_specialty_option])
        format.html { redirect_to snippets_path, notice: 'Provider specialty option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @provider_specialty_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provider_specialty_options/1
  # DELETE /provider_specialty_options/1.json
  def destroy
    @provider_specialty_option = ProviderSpecialtyOption.find(params[:id])
    @provider_specialty_option.destroy

    respond_to do |format|
      format.html { redirect_to provider_specialty_options_url }
      format.json { head :no_content }
    end
  end
end
