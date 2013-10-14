class AddPublishToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :publish, :boolean, :default => false
  end
end
