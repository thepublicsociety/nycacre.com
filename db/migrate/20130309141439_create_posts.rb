class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.string :author
      t.text :content
      t.string :tag
      t.string :category
      t.boolean :publish
      t.boolean :archive, :default => false
      t.boolean :featured
      t.string :sector

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
