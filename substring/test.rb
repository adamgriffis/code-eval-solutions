File.open(ARGV[0]).each_line do |line|
	args = line.strip.split(",")
	
	testStr = args[0]
	regexStr = args[1].gsub(/(?<!\\)(\*){1}/, ".*")
	regex = Regexp.new(regexStr)
	
	test = (testStr =~ regex).nil?
	puts !test
end