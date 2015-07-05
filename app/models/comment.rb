class Comment < ActiveRecord::Base
  belongs_to :company
  def self.search(search, page)
	  paginate per_page: 5, page: page, conditions: ['comment LIKE ?', "%#{search}%"], order: 'created_at DESC'
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      comment = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      comment.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      comment.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["comment", "company_id", "userstamp"]
  end

end
