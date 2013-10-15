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
	
	def min_dists(points)
		min_dist = -1
		points.each do |point|
			dist = self.distance(point)
			min_dist = dist if min_dist > dist || min_dist < 0
		end
		
		return min_dist
	end
	
	def distance(p1)
		Math.sqrt((x.to_f-p1.x)**2+(y.to_f-p1.y)**2)
	end
end

count = 0
points = []
File.open(ARGV[0]).each_line do |line|
	if ( count <= 0 )
		count = line.strip.to_i
		
		if points.length > 0 # we actualy read in points
			min_dist = -1
			(0..(points.length-2)).each do |idx|
				point= points[idx]
				other_pts = points[(idx+1)..(points.length-1)]
				dist = point.min_dists(other_pts)
				min_dist = dist if min_dist > dist || min_dist < 0
			end
			
			puts min_dist.round(4) if min_dist > 0 && min_dist <= 10000
			puts "INFINITY" if min_dist > 10000
		end
		points = []
		break if count == 0
	else
		count = count -1 
		elems = line.strip.split(" ")
		points.push(Point.new(elems[0].to_i, elems[1].to_i))
	end
end