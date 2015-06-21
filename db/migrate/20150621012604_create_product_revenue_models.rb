class CreateProductRevenueModels < ActiveRecord::Migration
  def change
    create_table :product_revenue_models do |t|
      t.references :product, index: true
      t.references :revenue_model, index: true

      t.timestamps
    end
  end
end
