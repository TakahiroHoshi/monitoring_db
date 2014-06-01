class CreateCompaniesTags < ActiveRecord::Migration
  def change
    create_table :companies_tags do |t|
      t.integer :company_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :companies_tags, [:company_id, :tag_id]
  end
end
