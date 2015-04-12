class CreateHrProcesses < ActiveRecord::Migration
  def change
    create_table :hr_processes do |t|
      t.string :hr_process_tag, index: true

      t.timestamps

    end
  end
end
