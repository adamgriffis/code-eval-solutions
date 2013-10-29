def pick_largest(array)
	array.uniq!
	
	return array if array.length <= 1
	
	array.sort_by!{|elem| elem.to_s.length*-1}
	
	max_length = array[0].length
	max_index = 0
	
	(1..array.length-1).each do |idx|
		max_index = idx if array[idx].to_s.length == max_length
	end
	
	return array[0..max_index]
end

def add_char(array, char)
	return array.map{|el| el.to_s + char}
end

def largest_common_subseq(s1, s2)
	#initialize
	matrix = Array.new(s1.length+1) {Array.new(s2.length+1) {[nil]}}
	#print "S1: " + s1.to_s
	#print "S2: " + s2.to_s
	
	(1..s1.length).each do |i|
		(1..s2.length).each do |j|
			new_arr = []
			if s1[i-1] == s2[j-1]
				#puts "match!"
				new_arr = add_char(matrix[i-1][j-1], s1[i-1])
				#puts new_arr.join(",")
			else
				new_arr = matrix[i-1][j] + matrix[i][j-1]
			end
			
			new_arr = pick_largest(new_arr)
			matrix[i][j] = new_arr
		end
	end

=begin
	(0..s1.length).each do |i|
		(0..s2.length).each do |j|
			print matrix[i][j].join(",")
		end
		puts ""
	end
=end
	
	return matrix[s1.length][s2.length][0]
end

File.open(ARGV[0]).each_line do |line|
	line.strip!
	elems = line.split(";")
	largest_ss = largest_common_subseq(elems[0], elems[1])
	puts largest_ss.to_s
end