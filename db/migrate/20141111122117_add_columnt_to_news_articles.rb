class AddColumntToNewsArticles < ActiveRecord::Migration
  def change
  	add_column :news_articles, :company_id, :integer
  end
end
