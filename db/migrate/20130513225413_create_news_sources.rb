class CreateNewsSources < ActiveRecord::Migration
  def change
    create_table :news_sources do |t|
      t.string :website
      t.string :name
      t.string :feed_url

      t.timestamps
    end
  end
end
