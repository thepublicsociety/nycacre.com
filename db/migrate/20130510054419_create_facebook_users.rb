class CreateFacebookUsers < ActiveRecord::Migration
  def change
    create_table :facebook_users do |t|
      t.string :token
      t.string :name
      t.string :uid

      t.timestamps
    end
  end
end
