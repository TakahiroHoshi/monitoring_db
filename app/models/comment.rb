class Comment < ActiveRecord::Base
  belongs_to :company

  def self.search(search, page)
	  paginate per_page: 30, page: page, conditions: ['comment LIKE ?', "%#{search}%"], order: 'created_at ASC'
  end

end
