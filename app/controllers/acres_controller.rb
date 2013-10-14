class AcresController < ApplicationController
  before_filter :set_class
  load_and_authorize_resource
  # GET /acres
  # GET /acres.xml
  def index
    @acres = Acre.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @acres }
    end
  end

  # GET /acres/1
  # GET /acres/1.xml
  def show
    @acre = Acre.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @acre }
    end
  end

  # GET /acres/new
  # GET /acres/new.xml
  def new
    @acre = Acre.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @acre }
    end
  end

  # GET /acres/1/edit
  def edit
    @acre = Acre.find(params[:id])
  end

  # POST /acres
  # POST /acres.xml
  def create
    @acre = Acre.new(params[:acre])

    respond_to do |format|
      if @acre.save
        format.html { redirect_to(acres_path, :notice => 'Acre was successfully created.') }
        format.xml  { render :xml => @acre, :status => :created, :location => @acre }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @acre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /acres/1
  # PUT /acres/1.xml
  def update
    @acre = Acre.find(params[:id])

    respond_to do |format|
      if @acre.update_attributes(params[:acre])
        format.html { redirect_to(acres_path, :notice => 'Acre was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @acre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /acres/1
  # DELETE /acres/1.xml
  def destroy
    @acre = Acre.find(params[:id])
    @acre.destroy

    respond_to do |format|
      format.html { redirect_to(acres_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin_acres"
  end
end
