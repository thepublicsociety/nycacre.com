class TenantApplicationsController < ApplicationController
  load_and_authorize_resource :except => [:create]
  before_filter :set_class
  # GET /tenant_applications
  # GET /tenant_applications.xml
  def index
    @tenant_applications = TenantApplication.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tenant_applications }
    end
  end

  # GET /tenant_applications/1
  # GET /tenant_applications/1.xml
  def show
    @tenant_application = TenantApplication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tenant_application }
    end
  end

  # GET /tenant_applications/new
  # GET /tenant_applications/new.xml
  def new
    @tenant_application = TenantApplication.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tenant_application }
    end
  end

  # GET /tenant_applications/1/edit
  def edit
    @tenant_application = TenantApplication.find(params[:id])
  end

  # POST /tenant_applications
  # POST /tenant_applications.xml
  def create
    @tenant_application = TenantApplication.new(params[:tenant_application])

    respond_to do |format|
      if @tenant_application.save
        SendMail.appnotification.deliver
        format.html { redirect_to("/contact", :notice => 'Application received') }
        format.xml  { render :xml => @tenant_application, :status => :created, :location => @tenant_application }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tenant_application.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tenant_applications/1
  # PUT /tenant_applications/1.xml
  def update
    @tenant_application = TenantApplication.find(params[:id])

    respond_to do |format|
      if @tenant_application.update_attributes(params[:tenant_application])
        format.html { redirect_to(administration_applicants_path, :notice => 'Tenant application was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tenant_application.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tenant_applications/1
  # DELETE /tenant_applications/1.xml
  def destroy
    @tenant_application = TenantApplication.find(params[:id])
    @tenant_application.destroy

    respond_to do |format|
      format.html { redirect_to(administration_applicants_path) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin_tenant_applications"
  end
end
