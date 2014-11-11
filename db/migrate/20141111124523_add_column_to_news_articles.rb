class AddColumnToNewsArticles < ActiveRecord::Migration
  def change
  	add_column :news_articles, :url, :string
  end
end
