class Advisor < ActiveRecord::Base
  attr_accessible :description, :name, :advisor_photo
  has_attached_file :advisor_photo
end
