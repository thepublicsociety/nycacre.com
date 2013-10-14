# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  bio        :text
#  created_at :datetime
#  updated_at :datetime
#

class Company < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :sectors
end
