class AddTelephoneToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :telephone, :string
  end
end
