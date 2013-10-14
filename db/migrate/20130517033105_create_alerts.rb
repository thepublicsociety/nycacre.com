class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :title
      t.text :content
      t.boolean :publish, :default => false

      t.timestamps
    end
  end
end
