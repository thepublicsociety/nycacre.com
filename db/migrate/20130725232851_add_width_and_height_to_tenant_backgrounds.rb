class AddWidthAndHeightToTenantBackgrounds < ActiveRecord::Migration
  def change
    add_column :tenant_backgrounds, :width, :string
    add_column :tenant_backgrounds, :height, :string
  end
end
