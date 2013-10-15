def bit_val(num, pos)
	return (num % (2**pos)) / 2**(pos-1)
end

File.open(ARGV[0]).each_line do |line|
	puts line
	nums = line.strip.split(",")
	x = nums[0].to_i
	p1 = nums[1].to_i
	p2 = nums[2].to_i
	
	puts bit_val(x,p1) == bit_val(x,p2)
end