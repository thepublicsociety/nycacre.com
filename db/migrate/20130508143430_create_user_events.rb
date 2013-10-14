class CreateUserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.string :origin
      t.datetime :event_start
      t.datetime :event_end
      t.string :name
      t.text :description
      t.string :url
      t.text :content
      t.string :location
      t.string :map
      t.integer :user_id

      t.timestamps
    end
  end
end
