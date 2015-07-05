csv_str = CSV.generate do |csv|
	csv << @products.column_names
	@products.each do |prd|
		csv << prd.attributes.values_at(*@products.column_names)
	end
end

NKF::nkf('-w -Lw', csv_str)
