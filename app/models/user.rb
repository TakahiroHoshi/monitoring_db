class User < ActiveRecord::Base
	before_save {self.email = email.downcase}
	validates :name, presence: true, length: {maximum: 30}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, length: {minimum: 8}



	class << self
	  #search
	  def search(query)
	  	rel = order("id")
	  	if query.present?
	  		rel = rel.where("name LIKE ? OR full_name LIKE ?",
	  			"%#{query}%", "%#{query}")
	  	end
	  	rel
	  end
	end

end
