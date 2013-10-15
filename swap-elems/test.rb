File.open(ARGV[0]).each_line do |line|
    args = line.strip.split(":")
	elems = args[0].split(" ")
	swaps = args[1]
	
	swaps.split(",").each do |swap|
		idxs = swap.split("-")
		idx1 = idxs[0].to_i
		idx2 = idxs[1].to_i
		
		swp = elems[idx1]
		elems[idx1] = elems[idx2]
		elems[idx2] = swp
	end
	
	puts elems.join(" ")
end