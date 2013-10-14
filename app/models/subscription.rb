# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  thing      :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Subscription < ActiveRecord::Base
  validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
end
