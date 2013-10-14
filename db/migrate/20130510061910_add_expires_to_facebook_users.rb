class AddExpiresToFacebookUsers < ActiveRecord::Migration
  def change
    add_column :facebook_users, :expires_at, :string
  end
end
