class FundingStatusOptionsController < ApplicationController
  # GET /funding_status_options
  # GET /funding_status_options.json
  def index
    @funding_status_options = FundingStatusOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @funding_status_options }
    end
  end

  # GET /funding_status_options/1
  # GET /funding_status_options/1.json
  def show
    @funding_status_option = FundingStatusOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @funding_status_option }
    end
  end

  # GET /funding_status_options/new
  # GET /funding_status_options/new.json
  def new
    @funding_status_option = FundingStatusOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @funding_status_option }
    end
  end

  # GET /funding_status_options/1/edit
  def edit
    @funding_status_option = FundingStatusOption.find(params[:id])
  end

  # POST /funding_status_options
  # POST /funding_status_options.json
  def create
    @funding_status_option = FundingStatusOption.new(params[:funding_status_option])

    respond_to do |format|
      if @funding_status_option.save
        format.html { redirect_to snippets_path, notice: 'Funding status option was successfully created.' }
        format.json { render json: @funding_status_option, status: :created, location: @funding_status_option }
      else
        format.html { render action: "new" }
        format.json { render json: @funding_status_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /funding_status_options/1
  # PUT /funding_status_options/1.json
  def update
    @funding_status_option = FundingStatusOption.find(params[:id])

    respond_to do |format|
      if @funding_status_option.update_attributes(params[:funding_status_option])
        format.html { redirect_to snippets_path, notice: 'Funding status option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @funding_status_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funding_status_options/1
  # DELETE /funding_status_options/1.json
  def destroy
    @funding_status_option = FundingStatusOption.find(params[:id])
    @funding_status_option.destroy

    respond_to do |format|
      format.html { redirect_to funding_status_options_url }
      format.json { head :no_content }
    end
  end
end
