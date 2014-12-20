class Product < ActiveRecord::Base
	belongs_to :company
	self.inheritance_column = nil

  def self.search(search)
    if search
      Product.where(['name LIKE ?', "%#{search}%"])
    else
      Product.all
    end
  end

end
