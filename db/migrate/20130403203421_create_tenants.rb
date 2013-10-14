class CreateTenants < ActiveRecord::Migration
  def self.up
    create_table :tenants do |t|
      t.string :name
      t.string :content_title
      t.text :content
      t.string :subcontent_title
      t.text :subcontent
      t.text :description
      t.string :sector
      t.boolean :publish
      t.boolean :featured

      t.timestamps
    end
  end

  def self.down
    drop_table :tenants
  end
end
