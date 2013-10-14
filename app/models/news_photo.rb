# == Schema Information
#
# Table name: news_photos
#
#  id                 :integer          not null, primary key
#  caption            :string(255)
#  post_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class NewsPhoto < ActiveRecord::Base
  belongs_to :post
  belongs_to :article
  belongs_to :tenant
  belongs_to :graduate
  has_attached_file :image, :styles => {:featured => "299x185>", :main => "631x298>", :thumb => "104x106>"}, :default_url => "/assets/empty.png"
end
