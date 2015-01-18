module ProductsHelper
	def find_company
		Company.find_by_id(@product.company_id)
	end
end
