def calc_max_vals(row, nextRow)
	row.each_index do |index|
		row[index] = row[index] + [nextRow[index], nextRow[index+1]].max
	end
end

triangle = []
File.open(ARGV[0]).each_line do |line|
	elems = line.strip.split(" ").map{|el| el.to_i}
	
	triangle.push(elems)
end

(2..triangle.length).each do |idx|
	calc_max_vals(triangle[triangle.length - idx], triangle[triangle.length - idx + 1])
end

puts triangle[0][0]