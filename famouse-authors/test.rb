File.open(ARGV[0]).each_line do |line|
	args = line.strip.split("|")
	msg = args[0]
	key = args[1].strip
	
	result = ""
	key.split(" ").map{|el| el.to_i}.each do |idx|
		result = result + msg[idx-1]
	end
	
	puts result
end