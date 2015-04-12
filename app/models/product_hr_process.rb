class ProductHrProcess < ActiveRecord::Base
  belongs_to :product
  belongs_to :hr_process
end
