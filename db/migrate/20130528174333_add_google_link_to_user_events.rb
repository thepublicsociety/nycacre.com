class AddGoogleLinkToUserEvents < ActiveRecord::Migration
  def change
    add_column :user_events, :google_link, :string
  end
end
