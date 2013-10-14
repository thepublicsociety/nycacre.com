# == Schema Information
#
# Table name: tenants
#
#  id                                  :integer          not null, primary key
#  name                                :string(255)
#  content_title                       :string(255)
#  content                             :text
#  subcontent_title                    :string(255)
#  subcontent                          :text
#  description                         :text
#  sector                              :string(255)
#  publish                             :boolean
#  featured                            :boolean
#  created_at                          :datetime
#  updated_at                          :datetime
#  tenant_image_file_name              :string(255)
#  tenant_image_content_type           :string(255)
#  tenant_image_file_size              :integer
#  tenant_image_updated_at             :datetime
#  tenant_secondary_image_file_name    :string(255)
#  tenant_secondary_image_content_type :string(255)
#  tenant_secondary_image_file_size    :integer
#  tenant_secondary_image_updated_at   :datetime
#  email                               :string(255)
#

class Tenant < ActiveRecord::Base
  has_many :news_photos, :dependent => :destroy
  accepts_nested_attributes_for :news_photos, :allow_destroy => true
  has_many :tenant_stats, :dependent => :destroy
  accepts_nested_attributes_for :tenant_stats, :allow_destroy => true
  has_many :users
  has_and_belongs_to_many :resumes
  has_many :job_postings
end
