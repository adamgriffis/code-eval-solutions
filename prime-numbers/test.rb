def is_prime(num, primes)
    primes.each do |prime| 
       return false if (num % prime) == 0 
    end
    
    return true
end

def find_primes(limit)
   primes = []
   (2..limit-1).each do |num| 
       if is_prime(num, primes) 
           primes.push(num)
       end
   end
   
   return primes;
end

File.open(ARGV[0]).each_line do |line|
    
    if line.strip.length > 0
       primes = find_primes(line.to_i)
	   puts primes.join(",")
    end
end