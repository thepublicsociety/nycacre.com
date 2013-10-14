class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.text :description
      t.string :specialty
      t.string :author
      t.text :content
      t.string :tag
      t.string :category
      t.string :sector
      t.string :tenant
      t.boolean :publish, :default => false
      t.timestamps
    end
  end
end
