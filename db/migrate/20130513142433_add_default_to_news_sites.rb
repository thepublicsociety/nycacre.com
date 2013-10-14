class AddDefaultToNewsSites < ActiveRecord::Migration
  def change
    change_column :news_sites, :publish, :boolean, :default => false
  end
end
