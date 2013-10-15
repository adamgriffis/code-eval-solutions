File.open(ARGV[0]).each_line do |line|
    chars = line.strip.chars.to_a
    self_desc = true
	
    (0..(chars.length-1)).each do |idx| 
       count = chars.count(idx.to_s)
       self_desc = count == chars[idx].to_i
       break unless self_desc
    end
    
    puts self_desc ? "1" : "0"
end