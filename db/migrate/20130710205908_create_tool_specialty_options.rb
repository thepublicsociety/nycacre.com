class CreateToolSpecialtyOptions < ActiveRecord::Migration
  def change
    create_table :tool_specialty_options do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
