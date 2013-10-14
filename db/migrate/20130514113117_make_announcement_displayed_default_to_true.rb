class MakeAnnouncementDisplayedDefaultToTrue < ActiveRecord::Migration
  def up
    change_column :announcements, :displayed, :boolean, :default => true
  end

  def down
  end
end
