def is_prime(num, primes)
    primes.each do |prime| 
       return false if (num % prime) == 0 
	   
	   return true if (prime > Math.sqrt(num))
    end
    
    return true
end

def sum_of_primes(limit)
   primes = []
   sum = 0
   num = 2
   while primes.length < 1000
	   if is_prime(num, primes)
           primes.push(num)
		   sum = sum + num
       end
	   num = num + 1
   end
   
   return sum;
end

puts sum_of_primes(1000).to_s