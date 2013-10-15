def eval_exp(expressions)
	if  expressions.length <= 0 
		return 0
	else
		exp = expressions.shift
		
		if ( exp == "+" || exp == "/" || exp == "*" )
			lhs = eval_exp(expressions)
			rhs = eval_exp(expressions)
			
			return eval(lhs.to_s + exp + rhs.to_s)
		else
			return exp.to_i
		end
	end
end

File.open(ARGV[0]).each_line do |line|
    expressions = line.strip.split(" ")
    
	puts eval_exp(expressions)
end