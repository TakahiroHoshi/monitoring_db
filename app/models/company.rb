class Company < ActiveRecord::Base
	has_many :people
	validates :name, presence:true, length: {maximum: 200}

end
