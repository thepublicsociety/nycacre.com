# == Schema Information
#
# Table name: challenges
#
#  id                           :integer          not null, primary key
#  name                         :string(255)
#  content_title                :string(255)
#  content                      :text
#  subcontent_title             :string(255)
#  subcontent                   :text
#  featured                     :boolean
#  created_at                   :datetime
#  updated_at                   :datetime
#  challenge_image_file_name    :string(255)
#  challenge_image_content_type :string(255)
#  challenge_image_file_size    :integer
#  challenge_image_updated_at   :datetime
#

class Challenge < ActiveRecord::Base
  has_attached_file :challenge_image, :styles => {:display => "649x683>"}, :default_url => "/assets/blank_image.png"
  has_many :challenge_stats, :dependent => :destroy
  accepts_nested_attributes_for :challenge_stats, :allow_destroy => true
  
  after_save :update_featured
  
  private
  
  def update_featured
    @current = self
    if @current.featured
      Challenge.all.each do |c|
        unless c == @current
          c.update_attribute("featured", false)
        end
      end
    end
  end
end
