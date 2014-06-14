class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment

      t.timestamps
    end
    add_index :comments, :comment
  end
end
