# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  author     :string(255)
#  content    :text
#  tag        :string(255)
#  category   :string(255)
#  publish    :boolean
#  archive    :boolean
#  featured   :boolean
#  sector     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  subheading :text
#

class Post < ActiveRecord::Base
  has_many :news_photos, :dependent => :destroy
  accepts_nested_attributes_for :news_photos, :allow_destroy => true
  
  def url
    "/news/#{self.title.gsub(" ", "%20")}"
  end
  
  def published
    self.published_date.blank? ? self.created_at : self.published_date
  end
end
