def pascal_row(index, prevRow)
	return [1] if index == 1
	return [1,1] if index == 2
	
	result = [1]
	(0..prevRow.length-2).each do |idx1| 
		result.push(prevRow[idx1] + prevRow[idx1+1])
	end
	
	result.push(1)
end

File.open(ARGV[0]).each_line do |line|
    if line.strip.length > 0
		limit = line.strip.to_i
		result = ""
		row = []
		
		(1..limit).each do |num|
				row = pascal_row(num, row)
				result = result + " " + row.join(" ")
		end
		
		puts result
    end
end