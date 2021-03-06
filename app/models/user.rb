class User < ActiveRecord::Base
	before_save {self.email = email.downcase}
	before_create :create_remember_token
	validates :name, presence: true, length: {maximum: 30}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, length: {minimum: 8}

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	class << self
=begin
	  #search
	  def search(query)
	  	rel = order("id")
	  	if query.present?
	  		rel = rel.where("name LIKE ? OR full_name LIKE ?",
	  			"%#{query}%", "%#{query}")
	  	end
	  	rel
	  end
=end
		
		#emailによるサーチをid_num昇順で返す
	  def search(search, page)
      paginate per_page: 30, page: page, conditions: ['email LIKE ?', "%#{search}%"], order: 'id_num DESC'
  	end

	end

	private
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
