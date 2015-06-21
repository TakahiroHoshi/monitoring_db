class RevenueModel < ActiveRecord::Base
	has_many :product_revenue_models
	has_many :products, through: :product_revenue_models

  def self.search(search, page)
      paginate per_page: 30, page: page, conditions: ['rev_model LIKE ?', "%#{search}%"], order: 'id ASC'
  end

end
