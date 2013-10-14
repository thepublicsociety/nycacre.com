class AddUserIdToNewsSources < ActiveRecord::Migration
  def change
    add_column :news_sources, :user_id, :integer
  end
end
