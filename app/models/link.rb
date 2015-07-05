class Link < ActiveRecord::Base
	belongs_to :company
  def self.search(search, page)
    paginate per_page: 30, page: page, conditions: ['url LIKE ?', "%#{search}%"], order: 'url ASC'
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
    ["link_type", "url", "company_id"]
  end

end
