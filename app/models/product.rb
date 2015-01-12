class Product < ActiveRecord::Base
	belongs_to :company
	self.inheritance_column = nil

  acts_as_taggable
  acts_as_taggable_on :tags
  #scope :by_added_date, order("created_at DESC")


  def self.search(search, page)
      paginate per_page: 30, page: page, conditions: ['name LIKE ?', "%#{search}%"], order: 'name ASC'
  end

end
