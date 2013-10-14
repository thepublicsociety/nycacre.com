class AddWebsiteEmailAndTelephoneToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :website, :string
    add_column :resumes, :email, :string
    add_column :resumes, :telephone, :string
  end
end
