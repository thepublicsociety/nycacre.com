class AddTenantToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :tenant, :string
  end
end
