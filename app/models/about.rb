# == Schema Information
#
# Table name: abouts
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  content                  :text
#  subtitle                 :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  featured                 :boolean
#  about_image_file_name    :string(255)
#  about_image_content_type :string(255)
#  about_image_file_size    :integer
#  about_image_updated_at   :datetime
#

class About < ActiveRecord::Base
  has_attached_file :about_image, :styles => {:display => "631x298>"}, :default_url => "/assets/blank_image.png"
end
