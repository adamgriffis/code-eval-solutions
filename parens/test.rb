$opens =  (%w"( { [")

def is_open(char)
	return $opens.include?(char)
end

def open_char_for(char)
	return "{" if char == "}"
	return "(" if char == ")"
	return "[" if char == "]"
end

File.open(ARGV[0]).each_line do |line|
    if line.strip.length > 0
		stack = []
		
		valid = true
		
		line.chars.each do |char| 
			if is_open(char)
				stack.push(char)
			else
				openChar = open_char_for(char)
				lastChar = stack.pop()
				
				if lastChar != openChar
					valid = false
					break
				end
			end
		end
		
		puts valid.to_s.capitalize
    end
end