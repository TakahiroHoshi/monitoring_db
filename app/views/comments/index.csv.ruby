csv_str = CSV.generate do |csv|
	csv << @comments.column_names
	@comments.each do |comt|
		csv << comt.attributes.values_at(*@comments.column_names)
	end
end

NKF::nkf('-w -Lw', csv_str)
