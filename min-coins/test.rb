File.open(ARGV[0]).each_line do |line|
    if line.strip.length > 0 
		total = line.strip.to_i
		result = 0
		
		result = (total/5).to_i
		total = total % 5
		result += (total/3).to_i
		total = total % 3
		result += total
		
		puts result
	end
end