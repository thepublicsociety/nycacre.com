class AddAuthParamsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :refresh_token, :string
    add_column :users, :expires_at, :datetime
    add_column :users, :selected_calendar, :string
  end
end
