def iterate_num(num)
	result = 0
	num.to_s.chars.each do |char| 
		result = result + char.to_i**2
	end
	return result
end

File.open(ARGV[0]).each_line do |line|
	num = line.to_i
	prev_nums = [num]
	while num != 1 
		num = iterate_num(num)
		break if prev_nums.include?(num) # detect cycle 
		prev_nums.push(num)
	end
	
	puts num == 1 ? "1" : "0"
end