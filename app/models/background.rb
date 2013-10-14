class Background < ActiveRecord::Base
  attr_accessible :page_action, :page_controller, :page_url, :background_image, :height, :width
  has_attached_file :background_image, :styles => {:thumb => "100x100>"}, :default_url => "/assets/externalbg1.jpg"
end
