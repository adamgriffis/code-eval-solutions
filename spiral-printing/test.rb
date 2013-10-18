def get_matrix(rows, cols, elems)
	matrix = Array.new(rows) {Array.new(cols){nil}}
	
	elems.each_index do |idx|
		row = idx / cols
		col = idx % cols
		break if row > (rows-1)
		break if col > (cols - 1)
		matrix[row][col] = elems[idx]
	end
	
	return matrix
end

def do_spiral(rows, cols, matrix)
	result = ""
	cur_row = 0
	cur_col = 0
	buff = 0
	while true
		break if buff > cols / 2 
		# first, go right
		(buff..(cols-buff-1)).each do |col|
			cur_col = col
			break if matrix[cur_row][cur_col].nil?
			result += " " + matrix[cur_row][cur_col]
			matrix[cur_row][cur_col] = nil
		end
		
		#next, go down
		(buff+1..(rows-buff-1)).each do |row|
			cur_row = row
			break if matrix[cur_row][cur_col].nil?
			result += " " + matrix[cur_row][cur_col]
			matrix[cur_row][cur_col] = nil
		end
		
		#next, go left
		range = ((cols-buff-2)..(0+buff))
		(range.first).downto(range.last).each do |col|
			cur_col = col
			break if matrix[cur_row][cur_col].nil?
			result += " " + matrix[cur_row][cur_col]
			matrix[cur_row][cur_col] = nil
		end
		
		#finally, go up
		range = ((rows-buff-2)..(0+buff+1))
		(range.first).downto(range.last).each do |row|
			cur_row = row
			break if matrix[cur_row][cur_col].nil?
			result += " " + matrix[cur_row][cur_col]
			matrix[cur_row][cur_col] = nil
		end
		
		buff += 1
	end
	
	return result
end

File.open(ARGV[0]).each_line do |line|
	args = line.strip.split(";")
	n = args[0].to_i
	m = args[1].to_i
	elems = args[2].split(" ")
	
	matrix = get_matrix(n, m, elems)
=begin
	matrix.each do |row| 
		puts row.join(" ")
	end
=end
	
	puts do_spiral(n, m, matrix).strip
end