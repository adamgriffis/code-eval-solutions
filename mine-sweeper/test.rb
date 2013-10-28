class MineField
	def initialize(m,n,field)
		@height = m
		@width = n
		@field = field.chars.to_a
	end
	
	def get_index(x,y)
		#puts "get_index: " + x.to_s + "," + y.to_s + " = " + (y*@width + x).to_s
		y*@width + x
	end
	
	def is_mine(x,y)
		return 0 if x < 0 || x >= @width || y < 0 || y >= @height
		#puts "Checking: " + x.to_s + "," + y.to_s + ": " + @field[get_index(x,y)].to_s
		return 1 if @field[get_index(x,y)] == "*"
		return 0
	end
	
	def get_x(index)
		index % @width
	end
	
	def get_y(index)
		index / @width
	end
	
	def process_field
		@field.each_index do |idx|
			if @field[idx] != "*"			
				x = get_x(idx)
				y = get_y(idx)
			
				count = 0
				count += is_mine(x+1,y+1)
				count += is_mine(x+1,y)
				count += is_mine(x+1,y-1)
				count += is_mine(x,y+1)
				count += is_mine(x,y-1)
				count += is_mine(x-1,y+1)
				count += is_mine(x-1,y)
				count += is_mine(x-1,y-1)
				
				@field[idx] = count
			end
		end
		
		return @field.join("")
	end
end

File.open(ARGV[0]).each_line do |line|
    line.strip!
	elems = line.split(";")
	dims = elems[0].split(",")
	m = dims[0].to_i
	n = dims[1].to_i
	field = elems[1]
	
	#puts "Field: " + field.to_s
	
	mf = MineField.new(m, n, field)
	puts mf.process_field
end