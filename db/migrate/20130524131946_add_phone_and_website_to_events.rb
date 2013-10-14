class AddPhoneAndWebsiteToEvents < ActiveRecord::Migration
  def change
    add_column :events, :phone, :string
    add_column :events, :website, :string
  end
end
