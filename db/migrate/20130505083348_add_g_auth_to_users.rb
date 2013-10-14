class AddGAuthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_oauth, :string
  end
end
