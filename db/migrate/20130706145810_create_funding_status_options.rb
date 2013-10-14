class CreateFundingStatusOptions < ActiveRecord::Migration
  def change
    create_table :funding_status_options do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
