class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'truncate_html' # string.truncate_html(0, at_end = "&hellip;").html_safe

  def after_sign_in_path_for(resource)
   administration_root_path
  end
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  def check_auth
    redirect_to root_url, :alert => "Access denied" unless current_user.try(:admin?)
  end
end
