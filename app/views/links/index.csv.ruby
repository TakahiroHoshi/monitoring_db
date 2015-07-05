csv_str = CSV.generate do |csv|
	csv << @links.column_names
	@links.each do |link|
		csv << link.attributes.values_at(*@links.column_names)
	end
end

NKF::nkf('-w -Lw', csv_str)
