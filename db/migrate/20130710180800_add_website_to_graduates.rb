class AddWebsiteToGraduates < ActiveRecord::Migration
  def change
    add_column :graduates, :website, :string
  end
end
