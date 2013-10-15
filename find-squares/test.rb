class Point
	attr_accessor :x, :y
	
	def initialize(x,y)
		@x = x
		@y = y
	end
	
	def get_dists(p1, p2, p3)
		dist = [self.distance(p1), self.distance(p2), self.distance(p3)]
		return dist.uniq
	end
	
	def distance(p1)
		Math.sqrt((x.to_f-p1.x)**2+(y.to_f-p1.y)**2)
	end
end

File.open(ARGV[0]).each_line do |line|
	
	line = line.strip.gsub(/(\(|\))/, "") # get rid of the parens, they just make everything harder
	
	elems = line.split(",")
	points = []
	
	elems.each_slice(2) do |slice|
		points.push(Point.new(slice[0].to_i,slice[1].to_i))
	end
	
	dists = []
	square = true
	points.each do |point|
		other_pts = (points-[point])
		dists += point.get_dists(other_pts[0], other_pts[1], other_pts[2])
		square = (dists.uniq.count == 2)
		break if !square
	end
	
	puts square
end