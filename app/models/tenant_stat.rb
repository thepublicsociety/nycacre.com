class TenantStat < ActiveRecord::Base
  attr_accessible :description, :name, :publish, :tenant_id, :value, :is_dollar_value
  belongs_to :tenant
end
