class Person < ActiveRecord::Base
	belongs_to :company
	validates :name, presence:true, length: {maximum: 100}
	validates :position, presence:true, length: {maximum: 100}
	validates :company_id, presence:true
end
