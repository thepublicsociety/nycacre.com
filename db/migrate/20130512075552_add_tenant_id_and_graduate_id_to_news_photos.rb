class AddTenantIdAndGraduateIdToNewsPhotos < ActiveRecord::Migration
  def change
    add_column :news_photos, :tenant_id, :integer
    add_column :news_photos, :graduate_id, :integer
  end
end
