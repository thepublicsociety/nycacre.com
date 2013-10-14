class AddResumeTenants < ActiveRecord::Migration
  def up
    create_table :resumes_tenants, :id => false do |t|
      t.integer :resume_id
      t.integer :tenant_id
    end
  end

  def down
    drop_table :resumes_tenants
  end
end
