class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.binary :logo
      t.text :description
      t.date :founded_date
      t.date :closed_date
      t.string :stage

      t.timestamps
    end
    add_index :companies, [:name, :stage]
  end
end
