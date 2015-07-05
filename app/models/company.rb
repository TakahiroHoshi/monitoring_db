class Company < ActiveRecord::Base
	validates :name, presence:true

#  acts_as_taggable
#  acts_as_taggable_on :categories
#  scope :by_added_date, order("created_at DESC")

  has_many :products
  has_many :comments
  has_many :links
  has_many :news_articles

  #PaperClipの:logo_image設定.
  has_attached_file :logo_image, styles: {medium: "300x300>", thumb: "100x100>"},
    :url => "/assets/logo_images/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/logo_images/:id/:style/:basename.:extension"
  validates_attachment :logo_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  #Companyモデルにネストした子テーブル(newでまとめてCompanyに付属する子テーブルのレコードを作るときに使う)
	accepts_nested_attributes_for :products
	accepts_nested_attributes_for :comments
	accepts_nested_attributes_for :links
	accepts_nested_attributes_for :news_articles

  def self.search(search, page)
      paginate per_page: 30, page: page, conditions: ['name LIKE ?', "%#{search}%"], order: 'name ASC'
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      company = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      company.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      company.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name", "description", "founded_date", "closed_date", "stage", "hq_country", "multinational"]
  end

end
