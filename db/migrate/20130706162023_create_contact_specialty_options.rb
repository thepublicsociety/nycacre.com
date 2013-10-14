class CreateContactSpecialtyOptions < ActiveRecord::Migration
  def change
    create_table :contact_specialty_options do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
