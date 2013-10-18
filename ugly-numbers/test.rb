def is_uggo(num)
	return ((num%2 == 0) || (num%3 == 0) || (num%5 == 0) || (num%7==0))
end

def find_uggos(strPrefix, strRemaining)
	if ( strRemaining.length == 0) 
		num = eval(strPrefix.gsub(/0+(?=\d)/,"")) # strip all leading zeros on numbers, this causes weird issues, think it's evaluating as hex or something?
		return is_uggo(num) ? 1 : 0
	else
		remaining = strRemaining[1..strRemaining.length]
		curr_char = strRemaining[0]
		return find_uggos(strPrefix + "+" + curr_char, remaining) + find_uggos(strPrefix + "-" + curr_char, remaining) + find_uggos(strPrefix + curr_char, remaining)
	end
end

File.open(ARGV[0]).each_line do |line|
	#puts line
	line.strip!
	orig_line = line.clone
	orig_length = line.length
	line.gsub!(/^0+/, "0") #multiple leading zeros are irrelevant, strip all but the first
	new_length = line.length
	
	num_uggos = find_uggos(line[0], line[1..line.length])
	if new_length < orig_length
		num_uggos = 3**(orig_length-new_length)*num_uggos
	end
	
	#puts line
	#puts (orig_length-new_length)
	puts num_uggos
end