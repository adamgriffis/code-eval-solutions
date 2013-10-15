File.open(ARGV[0]).each_line do |line|
	words = line.strip.split(" ")
	if words.length > 0 
		puts words.reverse.join(" ")
	end
end