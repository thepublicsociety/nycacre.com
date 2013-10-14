class CreateAdvisors < ActiveRecord::Migration
  def change
    create_table :advisors do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
