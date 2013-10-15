File.open(ARGV[0]).each_line do |line|
    args = line.split(",")
    
    wordLength = args[0].to_i
    chars = args[1].strip.chars.to_a.uniq.sort
    words = [""]
    
    (1..wordLength).each do |currWordLength|
        while (words[0].length < currWordLength )
            currWord = words.shift
            
            chars.each do |char| 
                words.push currWord + char
            end
        end
    end
	
	puts words.join(",")
end