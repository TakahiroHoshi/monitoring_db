class NewsArticle < ActiveRecord::Base
	belongs_to :company

  def self.search(search, page)
    paginate per_page: 30, page: page, conditions: ['title LIKE ?', "%#{search}%"], order: 'title ASC'
  end
end
