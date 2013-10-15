def print_digit(val, code, dig, next_code, next_dig, str)
	str = ""
	if val >= dig 
		cnt = (val / dig)
		(1..cnt).each{|idx| str = str + code}
		val = val % dig
	end
	
	if val >= (dig - next_dig)
		str = str + next_code + code
		val = val - (dig - next_dig)
	end
	
	print str if str.length > 0
	return val
end

File.open(ARGV[0]).each_line do |line|
	num = line.strip.to_i
	str = ""
	
	num = print_digit(num, "M", 1000, "C", 100, str)
	num = print_digit(num, "D", 500, "C", 100, str)
	num = print_digit(num, "C", 100, "X", 10, str)
	num = print_digit(num, "L", 50, "X", 10, str)
	num = print_digit(num, "X", 10, "I", 1, str)
	num = print_digit(num, "V", 5, "I", 1, str)
	num = print_digit(num, "I", 1, "", 0, str)
	
	puts ""
end