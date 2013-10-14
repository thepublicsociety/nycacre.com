class AddSubheadingToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :subheading, :text
  end

  def self.down
    remove_column :posts, :subheading
  end
end
