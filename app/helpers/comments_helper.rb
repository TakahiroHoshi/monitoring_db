module CommentsHelper
	def find_company
		company = Company.find_by_id(@comment.company_id)
	end
end
