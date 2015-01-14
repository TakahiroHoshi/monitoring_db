module NewsArticlesHelper
	def find_company
		Company.find_by_id(@news_article.company_id)
	end
end
