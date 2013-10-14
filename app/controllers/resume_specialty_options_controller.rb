class ResumeSpecialtyOptionsController < ApplicationController
  # GET /resume_specialty_options
  # GET /resume_specialty_options.json
  def index
    @resume_specialty_options = ResumeSpecialtyOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resume_specialty_options }
    end
  end

  # GET /resume_specialty_options/1
  # GET /resume_specialty_options/1.json
  def show
    @resume_specialty_option = ResumeSpecialtyOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resume_specialty_option }
    end
  end

  # GET /resume_specialty_options/new
  # GET /resume_specialty_options/new.json
  def new
    @resume_specialty_option = ResumeSpecialtyOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resume_specialty_option }
    end
  end

  # GET /resume_specialty_options/1/edit
  def edit
    @resume_specialty_option = ResumeSpecialtyOption.find(params[:id])
  end

  # POST /resume_specialty_options
  # POST /resume_specialty_options.json
  def create
    @resume_specialty_option = ResumeSpecialtyOption.new(params[:resume_specialty_option])

    respond_to do |format|
      if @resume_specialty_option.save
        format.html { redirect_to snippets_path, notice: 'Resume specialty option was successfully created.' }
        format.json { render json: @resume_specialty_option, status: :created, location: @resume_specialty_option }
      else
        format.html { render action: "new" }
        format.json { render json: @resume_specialty_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resume_specialty_options/1
  # PUT /resume_specialty_options/1.json
  def update
    @resume_specialty_option = ResumeSpecialtyOption.find(params[:id])

    respond_to do |format|
      if @resume_specialty_option.update_attributes(params[:resume_specialty_option])
        format.html { redirect_to snippets_path, notice: 'Resume specialty option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resume_specialty_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resume_specialty_options/1
  # DELETE /resume_specialty_options/1.json
  def destroy
    @resume_specialty_option = ResumeSpecialtyOption.find(params[:id])
    @resume_specialty_option.destroy

    respond_to do |format|
      format.html { redirect_to resume_specialty_options_url }
      format.json { head :no_content }
    end
  end
end
