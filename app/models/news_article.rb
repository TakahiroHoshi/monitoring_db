class NewsArticle < ActiveRecord::Base
	belongs_to :company

  def self.search(search, page)
    paginate per_page: 30, page: page, conditions: ['title LIKE ?', "%#{search}%"], order: 'title ASC'
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      news_article = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      news_article.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      news_article.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["date", "title", "content", "comment", "publisher", "company_id", "url"]
  end

end
