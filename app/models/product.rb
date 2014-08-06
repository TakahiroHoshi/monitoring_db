class Product < ActiveRecord::Base
	belongs_to :company
	self.inheritance_column = nil
end
