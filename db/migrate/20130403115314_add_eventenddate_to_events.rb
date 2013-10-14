class AddEventenddateToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :eventenddate, :datetime
  end

  def self.down
    remove_column :events, :eventenddate
  end
end
