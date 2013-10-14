class AddOriginToFeedEntries < ActiveRecord::Migration
  def change
    add_column :feed_entries, :origin, :string
  end
end
