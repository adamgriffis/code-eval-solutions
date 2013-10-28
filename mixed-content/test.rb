 File.open(ARGV[0]).each_line do |line|
    line.strip!
	elems = line.split(",")
	
	words = []
	nums = []
	
	elems.each do |elem|
		if (/\d+/ =~ elem).nil? #not a num
			words.push(elem)
		else
			nums.push(elem)
		end
	end
	
	puts words.join(",") + (words.size > 0 && nums.size > 0 ? "|" : "") + nums.join(",")
end