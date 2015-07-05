class HrProcess < ActiveRecord::Base
	has_many :product_hr_processes
	has_many :products, through: :product_hr_processes

  def self.search(search, page)
      paginate per_page: 30, page: page, conditions: ['hr_process_tag LIKE ?', "%#{search}%"], order: 'id ASC'
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      hrp = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      hrp.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      hrp.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["hr_process_tag"]
  end

end
