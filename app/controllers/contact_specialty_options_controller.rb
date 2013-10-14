class ContactSpecialtyOptionsController < ApplicationController
  # GET /contact_specialty_options
  # GET /contact_specialty_options.json
  def index
    @contact_specialty_options = ContactSpecialtyOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contact_specialty_options }
    end
  end

  # GET /contact_specialty_options/1
  # GET /contact_specialty_options/1.json
  def show
    @contact_specialty_option = ContactSpecialtyOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact_specialty_option }
    end
  end

  # GET /contact_specialty_options/new
  # GET /contact_specialty_options/new.json
  def new
    @contact_specialty_option = ContactSpecialtyOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact_specialty_option }
    end
  end

  # GET /contact_specialty_options/1/edit
  def edit
    @contact_specialty_option = ContactSpecialtyOption.find(params[:id])
  end

  # POST /contact_specialty_options
  # POST /contact_specialty_options.json
  def create
    @contact_specialty_option = ContactSpecialtyOption.new(params[:contact_specialty_option])

    respond_to do |format|
      if @contact_specialty_option.save
        format.html { redirect_to snippets_path, notice: 'Contact specialty option was successfully created.' }
        format.json { render json: @contact_specialty_option, status: :created, location: @contact_specialty_option }
      else
        format.html { render action: "new" }
        format.json { render json: @contact_specialty_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contact_specialty_options/1
  # PUT /contact_specialty_options/1.json
  def update
    @contact_specialty_option = ContactSpecialtyOption.find(params[:id])

    respond_to do |format|
      if @contact_specialty_option.update_attributes(params[:contact_specialty_option])
        format.html { redirect_to snippets_path, notice: 'Contact specialty option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact_specialty_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_specialty_options/1
  # DELETE /contact_specialty_options/1.json
  def destroy
    @contact_specialty_option = ContactSpecialtyOption.find(params[:id])
    @contact_specialty_option.destroy

    respond_to do |format|
      format.html { redirect_to contact_specialty_options_url }
      format.json { head :no_content }
    end
  end
end
