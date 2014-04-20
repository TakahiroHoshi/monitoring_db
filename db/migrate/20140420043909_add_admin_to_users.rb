class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :booleank, default: false
  end
end
