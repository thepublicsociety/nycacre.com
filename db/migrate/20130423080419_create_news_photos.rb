class CreateNewsPhotos < ActiveRecord::Migration
  def self.up
    create_table :news_photos do |t|
        t.string :caption
        t.integer :post_id
      t.timestamps
    end
  end

  def self.down
    drop_table :news_photos
  end
end
