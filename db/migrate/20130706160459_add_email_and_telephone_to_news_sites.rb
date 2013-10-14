class AddEmailAndTelephoneToNewsSites < ActiveRecord::Migration
  def change
    add_column :news_sites, :email, :string
    add_column :news_sites, :telephone, :string
  end
end
