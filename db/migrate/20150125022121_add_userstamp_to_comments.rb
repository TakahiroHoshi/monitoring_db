class AddUserstampToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :userstamp, :string
  end
end
