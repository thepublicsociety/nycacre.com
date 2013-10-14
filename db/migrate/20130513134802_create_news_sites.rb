class CreateNewsSites < ActiveRecord::Migration
  def change
    create_table :news_sites do |t|
      t.string :name
      t.text :description
      t.string :specialty
      t.string :author
      t.text :content
      t.string :tag
      t.string :category
      t.string :sector
      t.string :tenant
      t.boolean :publish
      t.string :website

      t.timestamps
    end
  end
end
