class Hole
	attr_accessor :width, :height
	def initialize(string)
		#strip out all of the [ and ] they just get in the way
		string.gsub!(/(\[|\]|\,)/," ")
		elems = string.split(" ")
		
		x1 = elems[0].to_i
		x2 = elems[2].to_i
		y1 = elems[1].to_i
		y2 = elems[3].to_i
		#puts "x1: " + x1.to_s + " y1: " + y1.to_s + " x2: " + x2.to_s + " y2: " + y2.to_s
		@width = (x1-x2).abs
		@height = (y1-y2).abs
	end
	
	def max_diagonal(min_brick_side)
		hole_side1 = @width
		hole_side2 = @height
		
		if @height > @width
			hole_side1 = @height
			hole_side2 = @width
		end
		
		sqrt_2 = Math.sqrt(2)
		
		if sqrt_2*min_brick_side >= hole_side1
			return -1 # we can't possible fit this in diagonally
		end
		
		max_diag = (hole_side2 - sqrt_2*(min_brick_side))**2 + (hole_side1 - sqrt_2*(min_brick_side))**2
		max_diag = Math.sqrt(max_diag)
		
		return max_diag
	end 
	
	def can_pass?(brick)
		#puts "Height: " + self.height.to_s + " Width: " + self.width.to_s
		#brick.print
		if brick.width <= self.width
			return true if brick.height <= self.height || brick.depth <= self.height
		end
		
		if brick.width <= self.height 
			return true if brick.height <= self.width || brick.depth <= self.width
		end
		
		if brick.height <= self.width
			return true if brick.width <= self.height || brick.depth <= self.height
		end
		
		if brick.height <= self.height 
			return true if brick.width <= self.width || brick.depth <= self.width
		end
		
		if brick.depth <= self.width
			return true if brick.width <= self.height || brick.height <= self.height
		end
		
		if brick.depth <= self.height 
			return true if brick.width <= self.width || brick.height <= self.width
		end
		
		min_sides = brick.min_sides
		max_diag = max_diagonal(min_sides[0])
		#puts min_sides.join(",")
		#puts "Max diag: " + max_diag.to_s
		if  max_diag >= min_sides[1]
			return true
		else
			max_diag = max_diagonal(min_sides[1])
			if max_diag >= min_sides[2]
				return true
			end
		end
		
		
		return false
	end
end

class Brick
	attr_accessor :width, :height, :depth, :index
	
	def initialize(string)
		#strip out all of the [,],),) and ",", they just get in the way
		string.gsub!(/(\[|\]|\(|\)|\,)/," ")
		elems = string.split(" ")
		
		@index = elems[0].to_i
		x1 = elems[1].to_i
		y1 = elems[2].to_i
		z1 = elems[3].to_i 
		
		x2 = elems[4].to_i
		y2 = elems[5].to_i
		z2 = elems[6].to_i

		@width = (x1-x2).abs
		@height = (y1-y2).abs
		@depth = (z1-z2).abs
	end
	
	def print
		puts "Brick " + @index.to_s + " Width: " + @width.to_s + " Height: " + @height.to_s + " Depth: " + @depth.to_s
	end
	
	def min_sides
		rslt = [@height, @width, @depth]
		rslt.sort!
		rslt = rslt[0..2]
		
		return rslt
	end
end

File.open(ARGV[0]).each_line do |line|
	line.strip!
	elems = line.split("|")
	
	hole_str = elems[0]
	brick_strs = elems[1].split(";")
	
	hole = Hole.new(hole_str)
	bricks = []
	
	brick_strs.each do |brick_str|
		brick = Brick.new(brick_str)
		bricks.push(brick.index) if hole.can_pass?(brick)
	end
	
	puts bricks.join(",") if bricks.size > 0
	puts "-" if bricks.size == 0
end