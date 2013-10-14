class AddWidthAndHeightToBackgrounds < ActiveRecord::Migration
  def change
    add_column :backgrounds, :width, :string
    add_column :backgrounds, :height, :string
  end
end
