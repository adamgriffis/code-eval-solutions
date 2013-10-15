def is_prime(num, primes)
    primes.each do |prime| 
       return false if (num % prime) == 0 
    end
    
    return true
end

def find_primes(m, n)
   primes = []
   resPrimes = []
   (2..n).each do |num| 
       if is_prime(num, primes)
           primes.push(num)
		   resPrimes.push(num) if num >= m
       end
   end
   
   return resPrimes;
end

File.open(ARGV[0]).each_line do |line|
    if line.strip.length > 0
	   nums = line.strip.split(",")
       primes = find_primes(nums[0].to_i, nums[1].to_i)
	   puts primes.length
    end
end