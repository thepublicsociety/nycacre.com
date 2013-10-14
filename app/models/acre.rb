# == Schema Information
#
# Table name: acres
#
#  id                      :integer          not null, primary key
#  title                   :string(255)
#  subtitle                :string(255)
#  content                 :text
#  featured                :boolean
#  created_at              :datetime
#  updated_at              :datetime
#  acre_image_file_name    :string(255)
#  acre_image_content_type :string(255)
#  acre_image_file_size    :integer
#  acre_image_updated_at   :datetime
#

class Acre < ActiveRecord::Base
  has_attached_file :acre_image, :styles => {:display => "104x106>"}, :default_url => "/assets/blank_image.png"
  after_save :update_featured
  
  private
  
  def update_featured
    @current = self
    if @current.featured
      Acre.all.each do |a|
        unless a == @current
          a.update_attribute("featured", false)
        end
      end
    end
  end
end
