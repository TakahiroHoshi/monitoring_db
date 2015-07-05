class Tag < ActiveRecord::Base
	has_many :products
#オリジナルのコード→ 	has_many :comapnies, through: :companies_tags, foreign_key: "tag_id", dependent: :destroy

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      tag = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      tag.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      tag.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name"]
  end

end
