module LinksHelper
	def find_company
		company = Company.find_by_id(@link.company_id)
	end
end
