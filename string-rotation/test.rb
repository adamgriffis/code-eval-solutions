File.open(ARGV[0]).each_line do |line|
    if line.strip.length > 0 
		args = line.strip.split(",")
		list1 = args[0].chars.to_a
		list2 = args[1].chars.to_a
		
		match = false
		
		(1..list1.length).each do |i|
			letter = list1.shift
			list1.push(letter)
			
			if ( list1 == list2 )
				match = true
				break
			end
		end
		
		puts match.to_s.capitalize
	end
end