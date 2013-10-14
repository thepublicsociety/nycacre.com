class AddCheckinsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :checkedin, :boolean, :default => false
    add_column :users, :restroom, :boolean, :default => false
  end

  def self.down
    remove_column :users, :restroom
    remove_column :users, :checkedin
  end
end
