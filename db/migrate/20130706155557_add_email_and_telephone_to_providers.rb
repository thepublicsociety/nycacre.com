class AddEmailAndTelephoneToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :email, :string
    add_column :providers, :telephone, :string
  end
end
