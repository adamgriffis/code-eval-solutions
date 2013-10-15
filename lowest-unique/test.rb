File.open(ARGV[0]).each_line do |line|
    nums = line.strip.split(" ").map{|el| el.to_i}
    
    low_unq = 0
    
    (1..9).each do |num|
       if nums.include?(num) && nums.count(num) == 1 
          low_unq = num
          break;
       end
    end
    
    puts low_unq == 0 ? "0" : nums.index(low_unq)+1
end