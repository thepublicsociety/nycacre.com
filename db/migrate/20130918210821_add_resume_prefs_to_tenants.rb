class AddResumePrefsToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :resume_prefs, :text
  end
end
