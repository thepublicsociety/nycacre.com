class AddDueDateToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :due_date, :datetime
  end
end
