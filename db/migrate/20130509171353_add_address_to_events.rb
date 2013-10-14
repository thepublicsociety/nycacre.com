class AddAddressToEvents < ActiveRecord::Migration
  def change
    add_column :events, :address_line_one, :string
    add_column :events, :address_line_two, :string
  end
end
