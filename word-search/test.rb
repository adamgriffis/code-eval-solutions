$grid = [
%w(A B C E),
%w(S F C S),
%w(A D E E)
]

$used = [
[false, false, false, false],
[false, false, false, false],
[false, false, false, false]
]

$width = 4
$height = 3

def reset_used
	$used.each_index do |row_idx|
		$used[row_idx].each_index do |col_idx|
			$used[row_idx][col_idx] = false
		end
	end
end

def get_letter_positions(char)
	pos = []
	
	$grid.each_index do |x|
		$grid[x].each_index do |y|
			pos.push([x,y]) if $grid[x][y] == char
		end
	end
	
	return pos
end

def is_feasible(pos)
	return false if (pos[0] < 0 || pos[0] >= $height || pos[1] < 0 || pos[1] >= $width)
	#puts (pos[0] >= $height).to_s
	#puts "Checking: " + pos[0].to_s + "," + pos[1].to_s
	return !$used[pos[0]][pos[1]]
end

def get_adjacent_positions(pos)
	result = [[pos[0]+1,pos[1]], [pos[0]-1,pos[1]], [pos[0],pos[1]+1], [pos[0],pos[1]-1]]
	result.select!{|cand| is_feasible(cand) }
	
	return result
end

def find_word(pos, curr_char, remaining_chars)
	#puts "Checking " + pos[0].to_s + "," + pos[1].to_s
	#puts "Looking for " + curr_char + " found " + $grid[pos[0]][pos[1]]
	#puts "Remaining: " + remaining_chars.join(",")
	if $grid[pos[0]][pos[1]] == curr_char && !$used[pos[0]][pos[1]]
		$used[pos[0]][pos[1]] = true
		
		if remaining_chars.length > 0
			next_char = remaining_chars.shift
			
			next_poses = get_adjacent_positions(pos)
			
			next_poses.each do |next_pos|
				#puts "About to check: " + next_pos[0].to_s + ", " + next_pos[1].to_s + " with remaining chars: " + remaining_chars.join(",")
				result = find_word(next_pos, next_char, remaining_chars)
				return true if result
			end
			
			remaining_chars.unshift(next_char)
			$used[pos[0]][pos[1]] = false
			return false 
		else
			$used[pos[0]][pos[1]] = false
			return true
		end
	else
		return false
	end
end

File.open(ARGV[0]).each_line do |line|
    line.strip!
	elems = line.chars.to_a
	
	curr_char = elems.shift
	candidates = get_letter_positions(curr_char)
	
	reset_used
	
	result = false

=begin	
	puts "Candidates for " + curr_char + ": "
	candidates.each do |can|
		puts can.join(",")
	end
=end
	
	candidates.each do |candidate|
		result = find_word(candidate, curr_char, elems)
		break if result
	end	
	
	#puts line
	puts result.to_s.capitalize
end