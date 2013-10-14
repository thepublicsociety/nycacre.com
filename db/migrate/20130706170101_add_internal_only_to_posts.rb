class AddInternalOnlyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :internal_only, :boolean, :default => false
  end
end
