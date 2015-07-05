csv_str = CSV.generate do |csv|
	csv << @tag.column_names
	@tag.each do |tag|
		csv << tag.attributes.values_at(*@tag.column_names)
	end
end

NKF::nkf('-w -Lw', csv_str)
