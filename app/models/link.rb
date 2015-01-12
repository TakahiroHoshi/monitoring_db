class Link < ActiveRecord::Base
	belongs_to :company
  def self.search(search, page)
      paginate per_page: 30, page: page, conditions: ['url LIKE ?', "%#{search}%"], order: 'url ASC'
  end
end
