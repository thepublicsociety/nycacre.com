class AddGoogleIdToUserEvents < ActiveRecord::Migration
  def change
    add_column :user_events, :google_id, :string
  end
end
