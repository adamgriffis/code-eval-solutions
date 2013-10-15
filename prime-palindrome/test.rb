def is_prime(num, primes)
    primes.each do |prime| 
       return false if (num % prime) == 0 
    end
    
    return true
end

def is_palindrome(num) 
   numStr = num.to_s
   return true unless numStr.length > 1
   half = (numStr.length / 2)
   
   return numStr[0..(half-1)] == numStr[(numStr.length()-half)..(numStr.length()-1)].reverse
end

def find_prime_palindrome(limit)
   primes = []
   largestPrimePalindrome = nil
   (2..limit).each do |num| 
       if is_prime(num, primes) 
           primes.push(num)
           if is_palindrome(num)
              largestPrimePalindrome = num 
           end
       end
   end
   
   return largestPrimePalindrome;
end

puts find_prime_palindrome(1000).to_s