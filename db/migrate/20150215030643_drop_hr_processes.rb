class DropHrProcesses < ActiveRecord::Migration
  def change
  	drop_table :hr_processes
  end
end
