class ResumesController < ApplicationController
  load_and_authorize_resource :except => [:create]
  before_filter :set_class
  # GET /resumes
  # GET /resumes.xml
  def index
    @resumes = Resume.where("publish = ?", true)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resumes }
    end
  end

  # GET /resumes/1
  # GET /resumes/1.xml
  def show
    @resume = Resume.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resume }
    end
  end

  # GET /resumes/new
  # GET /resumes/new.xml
  def new
    @resume = Resume.new
    @resume_specialty_options = ResumeSpecialtyOption.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resume }
    end
  end

  # GET /resumes/1/edit
  def edit
    @resume = Resume.find(params[:id])
    @resume_specialty_options = ResumeSpecialtyOption.all
  end

  # POST /resumes
  # POST /resumes.xml
  def create
    @resume = Resume.create(params[:resume])
    tenant_ids = params[:direct].split(",")
    tenant_ids.each do |id|
      @resume.tenants << Tenant.find_by_id(id)
    end
  end

  # PUT /resumes/1
  # PUT /resumes/1.xml
  def update
    @resume = Resume.find(params[:id])

    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        if params[:resume][:publish] == "1"

            @resume.tenants.each do |t|
              t.users.each do |u|
                SendMail.resnotification(@resume, u.email).deliver
              end
            end

        end
        format.html { redirect_to(resumes_url, :notice => 'Resume was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.xml
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy

    respond_to do |format|
      format.html { redirect_to(resumes_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin_resumes"
  end
end
