class AddEmailToTenants < ActiveRecord::Migration
  def self.up
    add_column :tenants, :email, :string
  end

  def self.down
    remove_column :tenants, :email
  end
end
