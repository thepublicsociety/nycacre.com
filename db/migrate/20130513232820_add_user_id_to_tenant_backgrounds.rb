class AddUserIdToTenantBackgrounds < ActiveRecord::Migration
  def change
    add_column :tenant_backgrounds, :user_id, :integer
  end
end
