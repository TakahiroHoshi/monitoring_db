class Product < ActiveRecord::Base
	belongs_to :company
	self.inheritance_column = nil

  acts_as_taggable
  acts_as_taggable_on :tags
  scope :by_added_date, order("created_at DESC")


  def self.search(search)
    if search
      Product.where(['name LIKE ?', "%#{search}%"])
    else
      Product.all
    end
  end

end
