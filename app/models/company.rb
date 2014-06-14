class Company < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :categories
  scope :by_added_date, order("created_at DESC")
  has_many :people
  has_many :comments
  has_many :links
  has_many :locations
	validates :name, presence:true

end
