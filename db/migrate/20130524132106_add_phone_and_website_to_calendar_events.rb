class AddPhoneAndWebsiteToCalendarEvents < ActiveRecord::Migration
  def change
    add_column :calendar_events, :phone, :string
    add_column :calendar_events, :website, :string
  end
end
