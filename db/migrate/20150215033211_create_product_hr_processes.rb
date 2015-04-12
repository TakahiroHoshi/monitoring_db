class CreateProductHrProcesses < ActiveRecord::Migration
  def change
    create_table :product_hr_processes do |t|
      t.references :product, index: true
      t.references :hr_process, index: true

      t.timestamps
    end
  end
end
