class Announcement < ActiveRecord::Base
  attr_accessible :content, :headline, :url, :announcement_image, :displayed, :post_id, :tenant_id
  has_attached_file :announcement_image, :styles => {:display => "628x408>", :thumb => "400x200>"}, :default_url => "/assets/empty.png"
end
