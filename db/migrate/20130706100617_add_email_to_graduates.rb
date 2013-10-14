class AddEmailToGraduates < ActiveRecord::Migration
  def change
    add_column :graduates, :email, :string
  end
end
