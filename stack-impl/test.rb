class Stack
	def initialize
		@arr = []
	end
	
	def push (elem)
		@arr.insert(@arr.length,elem)
	end
	
	def pop 
		result = @arr[@arr.length-1]
		@arr.delete_at(@arr.length-1)
		return result
	end
	
	def has_more?
		return @arr.length > 0
	end
end

File.open(ARGV[0]).each_line do |line|
	elems = line.strip.split(" ")
	stack_impl = Stack.new()
	elems.each {|el| stack_impl.push(el) }
	
	alternate = true
	str = ""
	while stack_impl.has_more?
		el = stack_impl.pop
		if alternate 
			str = str + " " + el
			alternate = false
		else
			alternate = true
		end
	end
	
	puts str.strip
end