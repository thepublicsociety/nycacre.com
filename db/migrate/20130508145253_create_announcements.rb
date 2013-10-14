class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :headline
      t.text :content
      t.string :url

      t.timestamps
    end
  end
end
