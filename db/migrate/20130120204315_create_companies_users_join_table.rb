class CreateCompaniesUsersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :companies_users, :id => false do |t|
      t.integer :company_id
      t.integer :user_id
    end
  end

  def self.down
  end
end
