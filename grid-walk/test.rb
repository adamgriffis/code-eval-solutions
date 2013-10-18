$rows = 300
$cols = 300
$x_zero = 0
$y_zero = 0
$matrix = Array.new($rows){Array.new($cols){0}}

def is_feasible(pos)
	x = pos[0] - $x_zero 
	y = pos[1] - $y_zero
	
	return false if (x < 0 || y < 0) || y > x
	
	digits = x.abs.to_s.chars.to_a
	digits += y.abs.to_s.chars.to_a
	
	sum = 0
	
	digits.each do |digit|
		sum += digit.to_i
	end
	
	return sum <= 19
end

def is_visited(pos)
	x = pos[0]
	y = pos[1]
	return $matrix[x][y] == 1 #already visited
end

def mark_visited(pos)
	x = pos[0]
	y = pos[1]
	#puts "Visiting: " + x.to_s + " , " + y.to_s
	$matrix[x][y] = 1 #visited
end

def count_points(pos)
	if is_feasible(pos) && !is_visited(pos)
		result = (pos[0] == $x_zero || pos[1] == $y_zero) ? 0 : 1
		
		mark_visited(pos)
		
		result += count_points([pos[0]+1, pos[1]])
		result += count_points([pos[0]-1, pos[1]])
		result += count_points([pos[0], pos[1]+1])
		result += count_points([pos[0], pos[1]-1])
		
		return result
	else #this isn't even feasible, we shouldn't be here so we should return 0
		return 0
	end
end

puts ((298*4 + ( count_points([$x_zero, $y_zero]))*8) - 315).to_s