class Rectangle
	attr_accessor :left, :right, :top, :bottom
	def initialize(coords)
		@left = coords[0]
		@top = coords[1]
		@right = coords[2]
		@bottom = coords[3]
	end
	
	def side_contained_horiz (x)
		return x >= @left && x <= @right 
	end
	
	def side_contained_vert (y)
		return y >= @bottom && y <= @top
	end
end

File.open(ARGV[0]).each_line do |line|
    if line.strip.length > 0 
		coords = line.strip.split(",").to_a.map{|el| el.to_f}
		
		rect1 = Rectangle.new(coords[0..3])
		rect2 = Rectangle.new(coords[4..7])
		
		if rect1.left <= rect2.left 
			left = rect1
			right = rect2
		else	
			left = rect2
			right = rect1
		end
		
		if rect1.top >= rect2.top 
			top = rect1
			bottom = rect2
		else
			top = rect2
			bottom = rect1
		end
		
		overLap = left.side_contained_horiz(right.left) && top.side_contained_vert(bottom.top)
		
		puts overLap.to_s.capitalize
	end
end