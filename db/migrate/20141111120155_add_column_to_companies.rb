class AddColumnToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :multinational, :string
  end
end
