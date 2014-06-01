class Company < ActiveRecord::Base
  has_many :people
  has_many :tags, through: :companies_tags, foreign_key: "company_id", dependent: :destroy
	validates :name, presence:true

end
