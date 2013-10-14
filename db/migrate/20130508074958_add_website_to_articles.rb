class AddWebsiteToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :website, :string
  end
end
