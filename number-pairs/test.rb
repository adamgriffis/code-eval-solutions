File.open(ARGV[0]).each_line do |line|
    args = line.strip.split(";")
	goal = args[1].to_i
	elems = args[0].split(",").map!{|el| el.to_i}
	
	pairs = []
	i = 0
	while ( i < elems.length && elems[i] < (goal/2.0) )
		other_el = goal - elems[i]
		pairs.push(elems[i].to_s+","+other_el.to_s) if elems.include?(other_el)
		i = i + 1
	end	
	
	puts pairs.join(";") if pairs.length > 0
	puts "NULL" if pairs.length == 0
end