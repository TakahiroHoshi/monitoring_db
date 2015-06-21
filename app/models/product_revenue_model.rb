class ProductRevenueModel < ActiveRecord::Base
  belongs_to :product
  belongs_to :revenue_model

end
