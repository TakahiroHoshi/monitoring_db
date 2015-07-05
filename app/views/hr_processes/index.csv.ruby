csv_str = CSV.generate do |csv|
	csv << @hr_processes.column_names
	@hr_processes.each do |hrp|
		csv << hrp.attributes.values_at(*@hr_processes.column_names)
	end
end

NKF::nkf('-w -Lw', csv_str)
