File.open(ARGV[0]).each_line do |line|
	nums = line.strip.split(",")
	
	x = nums[0].to_i
	n = nums[1].to_i
	mult = x / n
	answer = n * mult
	answer = answer + n if answer < x
	
	puts answer
end