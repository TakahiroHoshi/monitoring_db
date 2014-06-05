class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.boolean :hq
      t.string :name
      t.string :country
      t.string :state
      t.string :address
      t.string :postal

      t.timestamps
    end
  end
end
