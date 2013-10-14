class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|
      t.string :position
      t.text :description
      t.string :salary
      t.datetime :available
      t.boolean :publish
      t.belongs_to :tenant

      t.timestamps
    end
  end
end
