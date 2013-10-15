File.open(ARGV[0]).each_line do |line|
	line.strip!
	
	line.gsub!(/([a-z ]|:(?!\))(?!\())+/, "x")
	nextLine = line
	
	while true do
		line = nextLine
		nextLine = line.gsub(/\((.*)\)/, '\1')
		break if nextLine.length == line.length
	end 
	
	line = nextLine
	
	line.gsub!(/((:\))|(:\())/, "")
	line.gsub!(/(:|x)/, "")
	line.gsub!(/\(\)/, "")
	puts ((line.length == 0) ? "YES" : "NO")
end