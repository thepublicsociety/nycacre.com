class AddActiveToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :active, :boolean, :default => true
  end
end
