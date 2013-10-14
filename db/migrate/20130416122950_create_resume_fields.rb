class CreateResumeFields < ActiveRecord::Migration
  def self.up
    create_table :resumes do |t|
      t.string :name
      t.string :specialty
      t.text :cover_letter

      t.timestamps
    end
  end

  def self.down
    drop_table :resumes
  end
end
