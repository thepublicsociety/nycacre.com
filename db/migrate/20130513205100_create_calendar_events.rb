class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.datetime :event_start
      t.datetime :event_end
      t.text :description
      t.string :name
      t.string :location
      t.string :origin
      t.integer :origin_id
      t.string :google_id

      t.timestamps
    end
  end
end
