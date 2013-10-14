class AddSocialLinksToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :facebook_link, :string
    add_column :tenants, :twitter_link, :string
  end
end
