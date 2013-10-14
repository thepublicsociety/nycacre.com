class CreateProviderSpecialtyOptions < ActiveRecord::Migration
  def change
    create_table :provider_specialty_options do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
