class CreateTenantApplications < ActiveRecord::Migration
  def self.up
    create_table :tenant_applications do |t|
      t.string :company_name
      t.string :company_technology
      t.string :funding_status
      t.string :inception
      t.text :value_proposition
      t.text :current_structure
      t.text :ownership
      t.text :description
      t.text :revenue_model
      t.text :benefits
      t.text :evolution_status
      t.text :competitors
      t.text :competition_edge
      t.text :sustainability
      t.text :intellectual_property
      t.text :target_market
      t.text :entry_barriers
      t.text :customers
      t.string :name_and_title
      t.string :address
      t.string :phone
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :tenant_applications
  end
end
