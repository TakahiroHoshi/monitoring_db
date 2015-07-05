csv_str = CSV.generate do |csv|
	csv << @news_articles.column_names
	@news_articles.each do |na|
		csv << na.attributes.values_at(*@news_articles.column_names)
	end
end

NKF::nkf('-w -Lw', csv_str)
