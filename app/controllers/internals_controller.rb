class InternalsController < ApplicationController
  def index
    @users = User.all
  end
  def checkin
    @users = User.all
    @userid = params[:id]
    @user = User.find(@userid)
    @option = params[:option]
    if @option == "checkin"
      @user.update_attribute("checkedin", true)
    else
      @user.update_attribute("checkedin", false)
    end
  end
end
