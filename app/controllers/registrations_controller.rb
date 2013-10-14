class RegistrationsController < Devise::RegistrationsController
  def new
    @bgimg = "/assets/internalbg1.jpg"
    @bgheight = Paperclip::Geometry.from_file(Rails.root.to_s+"/app/assets/images/internalbg1.jpg").height.to_i
    @bgwidth = Paperclip::Geometry.from_file(Rails.root.to_s+"/app/assets/images/internalbg1.jpg").width.to_i
  end
  def edit
    @bgimg = "/assets/internalbg1.jpg"
    @bgheight = Paperclip::Geometry.from_file(Rails.root.to_s+"/app/assets/images/internalbg1.jpg").height.to_i
    @bgwidth = Paperclip::Geometry.from_file(Rails.root.to_s+"/app/assets/images/internalbg1.jpg").width.to_i
  end
  protected

  def after_sign_up_path_for(resource)
    administration_root_path
  end
  def after_update_path_for(resource)
    administration_root_path
  end
end