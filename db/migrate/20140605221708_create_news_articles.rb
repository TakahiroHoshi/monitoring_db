class CreateNewsArticles < ActiveRecord::Migration
  def change
    create_table :news_articles do |t|
      t.date :date
      t.string :title
      t.text :content
      t.text :comment
      t.string :publisher

      t.timestamps
    end
  end
end
