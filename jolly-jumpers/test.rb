File.open(ARGV[0]).each_line do |line|
    
    if line.strip.length > 0
        jolly = true
        elems = line.strip.split(" ") 
        
        size = elems[0].to_i
        
        tracker = Array.new(size-1) { 0 }
        
        prevNum = elems[1].to_i
        
        (2..size).each do |i|
           nextNum = elems[i].to_i
           
           diff = (nextNum - prevNum).abs
           
           if diff == 0 || diff >= size || tracker[diff] == 1 
               jolly = false
               break
           else
               tracker[diff] = 1
           end
           
           prevNum = nextNum
        end
        
        puts (jolly ? "Jolly" : "Not Jolly")
    end
end