class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.string :page_controller
      t.string :page_action
      t.string :page_url

      t.timestamps
    end
  end
end
