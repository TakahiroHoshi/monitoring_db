csv_str = CSV.generate do |csv|
	csv << @companies.column_names
	@companies.each do |com|
		csv << com.attributes.values_at(*@companies.column_names)
	end
end

NKF::nkf('-w -Lw', csv_str)
