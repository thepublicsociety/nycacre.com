class AddPhoneAndWebsiteToUserEvents < ActiveRecord::Migration
  def change
    add_column :user_events, :phone, :string
    add_column :user_events, :website, :string
  end
end
