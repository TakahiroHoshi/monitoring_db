class AddLocationColumnsToCompanies < ActiveRecord::Migration
  def up
  	add_column :companies, :hq_country, :string
  end
end
