class Comment < ActiveRecord::Base
  belongs_to :company
  def self.search(search, page)
	  paginate per_page: 5, page: page, conditions: ['comment LIKE ?', "%#{search}%"], order: 'created_at DESC'
  end

end
