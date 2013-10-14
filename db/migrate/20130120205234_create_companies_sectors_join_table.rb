class CreateCompaniesSectorsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :companies_sectors, :id => false do |t|
      t.integer :company_id
      t.integer :sector_id
    end
  end

  def self.down
  end
end
