class RemoveHrProcessFromProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :hr_process
  end
end
