class CreateTenantStats < ActiveRecord::Migration
  def change
    create_table :tenant_stats do |t|
      t.integer :tenant_id
      t.string :name
      t.string :value
      t.text :description
      t.boolean :publish

      t.timestamps
    end
  end
end
