def create_matrix(width, height) # initialize a width x height $matrix of 0s
	Array.new(height) { Array.new(width) { 0 } }
end

def SetRow rowIdx, val
	$matrix[rowIdx].each_index { |idx| $matrix[rowIdx][idx] = val }
end

def SetCol colIdx, val
	$matrix.each_index { |idx| $matrix[idx][colIdx] = val }
end

def QueryRow rowIdx 
	sum = 0 
	$matrix[rowIdx].each { |val| sum = sum + val }
	
	puts sum
end

def QueryCol colIdx
	sum = 0
	$matrix.each { |row| sum = sum + row[colIdx] }
	
	puts sum
end

$matrix = create_matrix(256, 256)

File.open(ARGV[0]).each_line do |line|
	# we've already defined out $matrix and all of the needed functions, just eval each line as we come across it
	# we have one thing to fix -- the two arguments need a comma between them
	
	if !line.strip.nil?
		line = line.strip
		line[line.rindex(" ")] = "," if line.count(" ") > 1
		eval line
	end
end