class AddDefaultToArticles < ActiveRecord::Migration
  def change
    change_column :articles, :publish, :boolean, :default => false
  end
end
