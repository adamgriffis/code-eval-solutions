def is_palindrome(num) 
   numStr = num.to_s
   return true unless numStr.length > 1
   half = (numStr.length / 2)
   
   return numStr[0..(half-1)] == numStr[(numStr.length()-half)..(numStr.length()-1)].reverse
end

def get_reverse(num)
	num.to_s.reverse.to_i
end

File.open(ARGV[0]).each_line do |line|
    
    if line.strip.length > 0
       num = line.to_i
	   
	   steps = 0
	   while !is_palindrome(num) 
			num = num + get_reverse(num)
			steps = steps + 1
	   end
	   
	   puts steps.to_s + " " + num.to_s
    end
end