class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name
      t.string :website
      t.string :specialty
      t.text :description
      t.string :category
      t.string :tag
      t.boolean :publish, :default => false

      t.timestamps
    end
  end
end
