File.open(ARGV[0]).each_line do |line|
    longestWord = ""
    line.strip.split(" ").each do |word|
       if ( word.length > longestWord.length )
          longestWord = word 
       end
    end
    
    puts longestWord
end