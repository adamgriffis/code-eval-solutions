File.open(ARGV[0]).each_line do |line|
	line = line.strip.gsub(/(\(|\))/, "") # get rid of the parens, they just make everything harder
	args = line.split(";")
	
	centerCoords = args[0].split(":")[1].split(",")
	
	centerX = centerCoords[0].to_f
	centerY = centerCoords[1].to_f
	
	radius = args[1].split(":")[1].to_f
	
	pointCoords = args[2].split(":")[1].split(",")
	
	pointX = pointCoords[0].to_f
	pointY = pointCoords[1].to_f
	
	dist = Math.sqrt((centerX - pointX)**2 + (centerY - pointY)**2)
	
	puts (radius >= dist).to_s
end