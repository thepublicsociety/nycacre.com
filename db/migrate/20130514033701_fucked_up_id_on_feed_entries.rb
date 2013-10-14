class FuckedUpIdOnFeedEntries < ActiveRecord::Migration
  def up
    create_table :feed_entries do |t|
      t.string :title
      t.string :link
      t.datetime :published_date
      t.integer :id
      t.string :category
      t.string :author
      t.integer :user_id
      t.string :entry_id
      t.timestamps
    end
  end

  def down
  end
end
