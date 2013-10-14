class AddDisplayedToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :displayed, :boolean, :default => false
  end
end
