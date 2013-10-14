class JobPosting < ActiveRecord::Base
  attr_accessible :available, :description, :position, :publish, :salary, :tenant_id
  belongs_to :tenant
end
