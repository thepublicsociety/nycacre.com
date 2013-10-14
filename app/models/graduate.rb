# == Schema Information
#
# Table name: graduates
#
#  id                                    :integer          not null, primary key
#  name                                  :string(255)
#  content_title                         :string(255)
#  content                               :text
#  subcontent_title                      :string(255)
#  subcontent                            :text
#  description                           :text
#  sector                                :string(255)
#  publish                               :boolean
#  featured                              :boolean
#  created_at                            :datetime
#  updated_at                            :datetime
#  graduate_image_file_name              :string(255)
#  graduate_image_content_type           :string(255)
#  graduate_image_file_size              :integer
#  graduate_image_updated_at             :datetime
#  graduate_secondary_image_file_name    :string(255)
#  graduate_secondary_image_content_type :string(255)
#  graduate_secondary_image_file_size    :integer
#  graduate_secondary_image_updated_at   :datetime
#

class Graduate < ActiveRecord::Base
  has_many :news_photos, :dependent => :destroy
  accepts_nested_attributes_for :news_photos, :allow_destroy => true
end
