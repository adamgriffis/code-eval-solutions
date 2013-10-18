$rows = 4
$cols = 4
$matrix = Array.new($rows){Array.new($cols){0}}

def is_feasible(pos)
	row = pos[0]
	col = pos[1]
	
	return row >= 0 && row < $rows && col >= 0 && col < $cols && $matrix[row][col] == 0
end

def get_possible_positions(row, col)
	pos_arr = [[row-1,col],[row+1,col],[row,col-1],[row,col+1]]
	
	return pos_arr.select{|pos| is_feasible(pos)}
end

def is_complete_path(pos)
	return pos[0] == ($rows-1) && pos[1] == ($cols-1)
end

def print_matrix
=begin
	$matrix.each do |row|
		puts row.join(" ")
	end
=end
end

def find_paths(pos, length)
	if is_complete_path(pos)
		print_matrix
		return 1
	else
		result = 0
		possible_pos_arr = get_possible_positions(pos[0], pos[1])
		
		possible_pos_arr.each do |new_pos|
			$matrix[new_pos[0]][new_pos[1]] = length+1 # mark that we're visiting this pos
			result += find_paths(new_pos, length+1)
			$matrix[new_pos[0]][new_pos[1]] = 0 # back out
		end
		
		return result
	end
end

$matrix[0][0] = 1
puts find_paths([0,0], 1)