class UpdateProduct < ActiveRecord::Migration
  def change
  	remove_column :products, :type
  	add_column :products, :hr_process, :string
  	add_column :products, :rev_model, :string
  end
end
