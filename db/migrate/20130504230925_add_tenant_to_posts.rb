class AddTenantToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tenant, :string
  end
end
