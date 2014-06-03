class Company < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :categories
  scope :by_added_date, order("created_at DESC")
  has_many :people
	validates :name, presence:true

end
