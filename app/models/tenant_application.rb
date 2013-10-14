# == Schema Information
#
# Table name: tenant_applications
#
#  id                    :integer          not null, primary key
#  company_name          :string(255)
#  company_technology    :string(255)
#  funding_status        :string(255)
#  inception             :string(255)
#  value_proposition     :text
#  current_structure     :text
#  ownership             :text
#  description           :text
#  revenue_model         :text
#  benefits              :text
#  evolution_status      :text
#  competitors           :text
#  competition_edge      :text
#  sustainability        :text
#  intellectual_property :text
#  target_market         :text
#  entry_barriers        :text
#  customers             :text
#  name_and_title        :string(255)
#  address               :string(255)
#  phone                 :string(255)
#  email                 :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

class TenantApplication < ActiveRecord::Base
  has_attached_file :cash_flow_statement
  has_attached_file :current_structure_file
end
