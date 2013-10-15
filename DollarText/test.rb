def get_single(num)
    if num == 0
        return "Zero"
    elsif num == 1
        return "One"
    elsif num == 2
        return "Two"
    elsif num == 3
        return "Three"
    elsif num == 4
        return "Four"
    elsif num == 5
        return "Five"
    elsif num == 6
        return "Six"
    elsif num == 7
        return "Seven"
    elsif num == 8
        return "Eight"
    elsif num == 9
        return "Nine"
    elsif num == 10
        return "Ten"
    elsif num == 11
        return "Eleven"
    elsif num == 12
        return "Twelve"
    elsif num == 13
        return "Thirteen"
    elsif num == 14
        return "Fourteen"
    elsif num == 15
        return "Fifteen"
    elsif num == 16
        return "Sixteen"
    elsif num == 17
        return "Seventeen"
    elsif num == 18
        return "Eighteen"
    elsif num == 19
        return "Nineteen"
    end
    
    return ""
end

def base_ten(num)
    if num == 2 
        return "Twenty"
    elsif num == 3
        return "Thirty"
    elsif num == 4
        return "Forty"
    elsif num == 5
        return "Fifty"
    elsif num == 6
        return "Sixty"
    elsif num == 7 
        return "Seventy"
    elsif num == 8
        return "Eighty"
    else
        return "Ninety"
    end
end

def get_tens(num)
    result = ""
    if num >= 20
        result = base_ten(num/10)
        remainder = num%10
		
        if remainder > 0 
            result = result + get_single(remainder)
        end
    else 
        result = get_single(num)
    end
    return result
end

def get_hundred_count(num)
   result = ""
   hundreds = (num/100)
   
   if hundreds > 0
       result = get_tens(hundreds) + "Hundred"
   end
   
   remainder = num % 100
   result = result + get_tens(remainder)
end

File.open(ARGV[0]).each_line do |line|
    origNum = line.to_i
    num = line.to_i
    result = ""
    
    if num >= 1000000
        result = get_hundred_count(num/1000000) + "Million"
        num = num % 1000000
    end 
    
    if num >= 1000
        result = result + get_hundred_count(num/1000) + "Thousand"
        num = num % 1000
    end
    
    result = result + get_hundred_count(num) + "Dollar"
    
    if origNum != 1
        result = result + "s"
    end
        
    puts result.to_s 
end