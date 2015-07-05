class RevenueModel < ActiveRecord::Base
	has_many :product_revenue_models
	has_many :products, through: :product_revenue_models

  def self.search(search, page)
      paginate per_page: 30, page: page, conditions: ['rev_model LIKE ?', "%#{search}%"], order: 'id ASC'
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      rev = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      rev.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      rev.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["rev_model"]
  end

end
