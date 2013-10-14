class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :item_type
      t.text :notes

      t.timestamps
    end
  end
end
