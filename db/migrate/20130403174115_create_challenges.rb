class CreateChallenges < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.string :name
      t.string :content_title
      t.text :content
      t.string :subcontent_title
      t.text :subcontent
      t.boolean :featured

      t.timestamps
    end
  end

  def self.down
    drop_table :challenges
  end
end
