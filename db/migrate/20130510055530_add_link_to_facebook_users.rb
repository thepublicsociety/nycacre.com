class AddLinkToFacebookUsers < ActiveRecord::Migration
  def change
    add_column :facebook_users, :link, :string
  end
end
