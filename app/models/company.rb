class Company < ActiveRecord::Base
	validates :name, presence:true

#  acts_as_taggable
#  acts_as_taggable_on :categories
#  scope :by_added_date, order("created_at DESC")

  has_many :products
  has_many :comments
  has_many :links
  has_many :news_articles

  #PaperClipの:logo_image設定
  has_attached_file :logo_image, styles: {medium: "300x300>", thumb: "100x100>"},
    :url => "/assets/logo_images/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/logo_images/:id/:style/:basename.:extension"
  validates_attachment :logo_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  #Companyモデルにネストした子テーブル(newでまとめてCompanyに付属する子テーブルのレコードを作るときに使う)
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
