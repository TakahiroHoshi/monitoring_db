class CreateRevenueModels < ActiveRecord::Migration
  def change
    create_table :revenue_models do |t|
      t.string :rev_model

      t.timestamps
    end
  end
end
