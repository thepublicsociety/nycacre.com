class CreateNewsSiteSpecialtyOptions < ActiveRecord::Migration
  def change
    create_table :news_site_specialty_options do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
