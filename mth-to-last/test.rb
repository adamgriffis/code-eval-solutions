File.open(ARGV[0]).each_line do |line|
	elems = line.strip.split(" ")
	
	mth = elems.last.to_i
	
	puts elems[elems.length - mth - 1] if (mth + 1) <= elems.length
end