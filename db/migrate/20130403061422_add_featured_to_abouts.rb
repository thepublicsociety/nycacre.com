class AddFeaturedToAbouts < ActiveRecord::Migration
  def self.up
    add_column :abouts, :featured, :boolean
  end

  def self.down
    remove_column :abouts, :featured
  end
end
