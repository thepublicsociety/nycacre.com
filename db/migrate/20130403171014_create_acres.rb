class CreateAcres < ActiveRecord::Migration
  def self.up
    create_table :acres do |t|
      t.string :title
      t.string :subtitle
      t.text :content
      t.boolean :featured

      t.timestamps
    end
  end

  def self.down
    drop_table :acres
  end
end
