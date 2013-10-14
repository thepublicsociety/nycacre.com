class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.text :content
      t.integer :question_id
      t.integer :votes
      t.boolean :accepted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
