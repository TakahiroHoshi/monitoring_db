class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :id_num
      t.string :organization

      t.timestamps
    end
  end
end
