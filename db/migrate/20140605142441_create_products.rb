class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :type
      t.date :released_date

      t.timestamps
    end
    add_index :products, :name
    add_index :products, :type
  end
end
