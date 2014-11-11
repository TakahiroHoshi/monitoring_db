class ChangeColumnToLinks < ActiveRecord::Migration
  def change
  	rename_column :links, :type, :link_type
  end
end
