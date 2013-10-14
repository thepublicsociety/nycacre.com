class AddOriginIdToUserEvents < ActiveRecord::Migration
  def change
    add_column :user_events, :origin_id, :integer
  end
end
