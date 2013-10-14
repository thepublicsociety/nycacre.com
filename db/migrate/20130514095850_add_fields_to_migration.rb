class AddFieldsToMigration < ActiveRecord::Migration
  def change
    add_column :announcements, :tenant_id, :integer
    add_column :announcements, :post_id, :integer
  end
end
