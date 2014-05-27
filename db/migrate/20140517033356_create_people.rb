class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :position

      t.timestamps
    end
    add_index :people, [:name]
  end
end