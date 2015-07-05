csv_str = CSV.generate do |csv|
	csv << @revenue_models.column_names
	@revenue_models.each do |rev|
		csv << rev.attributes.values_at(*@revenue_models.column_names)
	end
end

NKF::nkf('-w -Lw', csv_str)
