File.open(ARGV[0]).each_line do |line|
    if line.strip.length > 0 
		args = line.strip.split(";")
		length = args[1].to_i
		elems = args[0].split(",")
		
		elems = elems.each_slice(length).to_a
		elems = elems.each do |sub_arr| 
			sub_arr.reverse! if sub_arr.length == length
		end
		
		puts elems.join(",")
	end
end