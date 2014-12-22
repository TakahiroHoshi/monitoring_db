class Tag < ActiveRecord::Base
	#has_many :comapnies
	has_many :products
#オリジナルのコード→ 	has_many :comapnies, through: :companies_tags, foreign_key: "tag_id", dependent: :destroy
end
