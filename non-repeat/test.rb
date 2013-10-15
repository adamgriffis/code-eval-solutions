File.open(ARGV[0]).each_line do |line|
    chars = line.strip.chars.to_a
    
    chars.each do |char|
       if chars.count(char) == 1 
			puts char
			break
	   end
    end
end