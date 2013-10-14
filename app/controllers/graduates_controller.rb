class GraduatesController < ApplicationController
  load_and_authorize_resource
  before_filter :set_class
  # GET /graduates
  # GET /graduates.xml
  def index
    @graduates = Graduate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @graduates }
    end
  end

  # GET /graduates/1
  # GET /graduates/1.xml
  def show
    @graduate = Graduate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @graduate }
    end
  end

  # GET /graduates/new
  # GET /graduates/new.xml
  def new
    @graduate = Graduate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @graduate }
    end
  end

  # GET /graduates/1/edit
  def edit
    @graduate = Graduate.find(params[:id])
  end

  # POST /graduates
  # POST /graduates.xml
  def create
    @graduate = Graduate.new(params[:graduate])

    respond_to do |format|
      if @graduate.save
        format.html { redirect_to(graduates_url, :notice => 'Graduate was successfully created.') }
        format.xml  { render :xml => @graduate, :status => :created, :location => @graduate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @graduate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /graduates/1
  # PUT /graduates/1.xml
  def update
    @graduate = Graduate.find(params[:id])

    respond_to do |format|
      if @graduate.update_attributes(params[:graduate])
        format.html { redirect_to(graduates_url, :notice => 'Graduate was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @graduate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /graduates/1
  # DELETE /graduates/1.xml
  def destroy
    @graduate = Graduate.find(params[:id])
    @graduate.destroy

    respond_to do |format|
      format.html { redirect_to(graduates_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin_tenants"
  end
end
