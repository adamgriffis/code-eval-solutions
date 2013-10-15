File.open(ARGV[0]).each_line do |line|
    args = line.split(",")
    word1 = args[0].strip
    suffix = args[1].strip
    
	test = word1[(word1.length-suffix.length)..(word1.length-1)]
    if ( test == suffix )
        puts "1"
    else
        puts "0"
    end
end