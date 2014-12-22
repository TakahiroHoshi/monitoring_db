class Company < ActiveRecord::Base
	validates :name, presence:true

#  acts_as_taggable
#  acts_as_taggable_on :categories
#  scope :by_added_date, order("created_at DESC")

  has_many :products
  has_many :comments
  has_many :links
  has_many :news_articles

	accepts_nested_attributes_for :products
	accepts_nested_attributes_for :comments
	accepts_nested_attributes_for :links
	accepts_nested_attributes_for :news_articles

  def self.search(search)
    if search
      Company.where(['name LIKE ?', "%#{search}%"])
    else
      Company.all
    end
  end


end
