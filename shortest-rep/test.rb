File.open(ARGV[0]).each_line do |line|
	line = line.strip
	(0..(line.length - 1)).each do |idx|
		test = line[0..idx]*(line.length/(idx+1))
		if test == line
			puts idx+1
			break
		end
	end
end