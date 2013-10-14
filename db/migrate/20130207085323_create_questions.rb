class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.text :content
      t.integer :user_id
      t.boolean :answered, :default => false
      t.integer :votes
      t.boolean :closed, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
