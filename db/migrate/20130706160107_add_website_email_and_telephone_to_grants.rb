class AddWebsiteEmailAndTelephoneToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :website, :string
    add_column :grants, :email, :string
    add_column :grants, :telephone, :string
  end
end
