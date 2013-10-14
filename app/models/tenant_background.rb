class TenantBackground < ActiveRecord::Base
  attr_accessible :page_action, :page_controller, :page_url, :tenant_background_image, :user_id, :height, :width
  has_attached_file :tenant_background_image, :styles => {:thumb => "100x100>"}, :default_url => "/assets/externalbg1.jpg"
  belongs_to :user
end
