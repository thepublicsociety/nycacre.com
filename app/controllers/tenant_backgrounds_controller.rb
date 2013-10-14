class TenantBackgroundsController < ApplicationController
  load_and_authorize_resource
  before_filter :set_class
  # GET /tenant_backgrounds
  # GET /tenant_backgrounds.json
  def index
    @tenant_backgrounds = current_user.tenant_backgrounds

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tenant_backgrounds }
    end
  end

  # GET /tenant_backgrounds/1
  # GET /tenant_backgrounds/1.json
  def show
    @tenant_background = TenantBackground.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tenant_background }
    end
  end

  # GET /tenant_backgrounds/new
  # GET /tenant_backgrounds/new.json
  def new
    @tenant_background = TenantBackground.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tenant_background }
    end
  end

  # GET /tenant_backgrounds/1/edit
  def edit
    @tenant_background = TenantBackground.find(params[:id])
  end

  # POST /tenant_backgrounds
  # POST /tenant_backgrounds.json
  def create
    @tenant_background = current_user.tenant_backgrounds.create(params[:tenant_background])

    respond_to do |format|
      if @tenant_background.save
        @tenant_background.update_attribute("height", Paperclip::Geometry.from_file(@tenant_background.tenant_background_image.path).height.to_i)
        @tenant_background.update_attribute("width", Paperclip::Geometry.from_file(@tenant_background.tenant_background_image.path).width.to_i)
        format.html { redirect_to tenant_backgrounds_url, notice: 'Tenant background was successfully created.' }
        format.json { render json: @tenant_background, status: :created, location: @tenant_background }
      else
        format.html { render action: "new" }
        format.json { render json: @tenant_background.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tenant_backgrounds/1
  # PUT /tenant_backgrounds/1.json
  def update
    @tenant_background = TenantBackground.find(params[:id])

    respond_to do |format|
      if @tenant_background.update_attributes(params[:tenant_background])
        format.html { redirect_to tenant_backgrounds_url, notice: 'Tenant background was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tenant_background.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tenant_backgrounds/1
  # DELETE /tenant_backgrounds/1.json
  def destroy
    @tenant_background = TenantBackground.find(params[:id])
    @tenant_background.destroy

    respond_to do |format|
      format.html { redirect_to tenant_backgrounds_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin_backgrounds"
  end
end
