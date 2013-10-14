class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :eventdate
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
