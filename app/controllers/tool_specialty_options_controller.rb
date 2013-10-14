class ToolSpecialtyOptionsController < ApplicationController
  # GET /tool_specialty_options
  # GET /tool_specialty_options.json
  def index
    @tool_specialty_options = ToolSpecialtyOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tool_specialty_options }
    end
  end

  # GET /tool_specialty_options/1
  # GET /tool_specialty_options/1.json
  def show
    @tool_specialty_option = ToolSpecialtyOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tool_specialty_option }
    end
  end

  # GET /tool_specialty_options/new
  # GET /tool_specialty_options/new.json
  def new
    @tool_specialty_option = ToolSpecialtyOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tool_specialty_option }
    end
  end

  # GET /tool_specialty_options/1/edit
  def edit
    @tool_specialty_option = ToolSpecialtyOption.find(params[:id])
  end

  # POST /tool_specialty_options
  # POST /tool_specialty_options.json
  def create
    @tool_specialty_option = ToolSpecialtyOption.new(params[:tool_specialty_option])

    respond_to do |format|
      if @tool_specialty_option.save
        format.html { redirect_to @tool_specialty_option, notice: 'Tool specialty option was successfully created.' }
        format.json { render json: @tool_specialty_option, status: :created, location: @tool_specialty_option }
      else
        format.html { render action: "new" }
        format.json { render json: @tool_specialty_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tool_specialty_options/1
  # PUT /tool_specialty_options/1.json
  def update
    @tool_specialty_option = ToolSpecialtyOption.find(params[:id])

    respond_to do |format|
      if @tool_specialty_option.update_attributes(params[:tool_specialty_option])
        format.html { redirect_to @tool_specialty_option, notice: 'Tool specialty option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tool_specialty_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tool_specialty_options/1
  # DELETE /tool_specialty_options/1.json
  def destroy
    @tool_specialty_option = ToolSpecialtyOption.find(params[:id])
    @tool_specialty_option.destroy

    respond_to do |format|
      format.html { redirect_to tool_specialty_options_url }
      format.json { head :no_content }
    end
  end
end
