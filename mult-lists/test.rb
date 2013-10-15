def parse_elems(str)
	str.strip.split(" ").map{|el| el.to_i}
end

File.open(ARGV[0]).each_line do |line|
    listStrs = line.strip.split("|")
	
	list1 = parse_elems(listStrs[0])
	list2 = parse_elems(listStrs[1])
	list3 = Array.new(list1.length)
	
	list1.each_index do |idx|
		list3[idx] = list1[idx]*list2[idx]
	end
	
	puts list3.join(" ")
end