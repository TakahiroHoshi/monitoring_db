class Product < ActiveRecord::Base
	belongs_to :company
	self.inheritance_column = nil
 	has_many :product_hr_processes, autosave: true
 	has_many :hr_processes, through: :product_hr_processes
 	has_many :product_revenue_models, autosave: true
 	has_many :revenue_models, through: :product_revenue_models

  acts_as_taggable
  acts_as_taggable_on :tags
  #scope :by_added_date, order("created_at DESC")

  def self.search(search, page)
      paginate per_page: 30, page: page, conditions: ['name LIKE ?', "%#{search}%"], order: 'name ASC'
  end

end
