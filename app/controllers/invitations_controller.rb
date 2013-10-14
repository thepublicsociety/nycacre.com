class InvitationsController < Devise::InvitationsController
  def after_invite_path_for(resource)
    administration_cms_path
  end
end