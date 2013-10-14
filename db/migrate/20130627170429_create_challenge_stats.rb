class CreateChallengeStats < ActiveRecord::Migration
  def change
    create_table :challenge_stats do |t|
      t.integer :challenge_id
      t.string :name
      t.string :value
      t.text :description
      t.boolean :publish
      t.boolean :is_dollar_value, :default => false

      t.timestamps
    end
  end
end
