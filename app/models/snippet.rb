# == Schema Information
#
# Table name: snippets
#
#  id                         :integer          not null, primary key
#  name                       :string(255)
#  title                      :string(255)
#  content                    :text
#  created_at                 :datetime
#  updated_at                 :datetime
#  subcontent_title           :string(255)
#  subcontent                 :text
#  snippet_image_file_name    :string(255)
#  snippet_image_content_type :string(255)
#  snippet_image_file_size    :integer
#  snippet_image_updated_at   :datetime
#

class Snippet < ActiveRecord::Base
  has_attached_file :snippet_image, :styles => {:display => "631x298>"}, :default_url => "/assets/blank_image.png"
end
