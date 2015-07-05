class Product < ActiveRecord::Base
	belongs_to :company
	self.inheritance_column = nil
 	has_many :product_hr_processes, autosave: true
 	has_many :hr_processes, through: :product_hr_processes
 	has_many :product_revenue_models, autosave: true
 	has_many :revenue_models, through: :product_revenue_models

  acts_as_taggable
  acts_as_taggable_on :tags
  #scope :by_added_date, order("created_at DESC")

  def self.search(search, page)
      paginate per_page: 30, page: page, conditions: ['name LIKE ?', "%#{search}%"], order: 'name ASC'
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      product = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      product.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      product.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name", "description", "company_id", "rev_model"]
  end

end
