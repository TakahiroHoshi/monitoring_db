class AddObserverToUsers < ActiveRecord::Migration
  def change
    add_column :users, :observer, :boolean, default: false
  end
end
