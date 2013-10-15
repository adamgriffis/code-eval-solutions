def create_rows(elems, dim)
	result = elems.each_slice(dim).to_a
	return result
end

def create_cols(rows)
	cols = Array.new(rows.length) {[]}
	
	rows.each do |row|
		(0..(row.length-1)).each do |idx|
			cols[idx].push(row[idx])
		end
	end
	
	return cols
end

def create_squares(elems, dim)
	squares = Array.new(dim) {[]}
	sqrt = Math.sqrt(dim)
	slices = elems.each_slice(sqrt).to_a
	
	slices.each_index do |idx|
		squareIndex = (idx / dim) * sqrt + ((idx % dim) % sqrt)
		squares[squareIndex] += slices[idx]
	end
	
	return squares
end

def is_valid(coll, valid)
	return ((coll-valid).length == 0 && (valid-coll).length == 0)
end

File.open(ARGV[0]).each_line do |line|
    if line.strip.length > 0 
		args = line.strip.split(";")
		dim = args[0].to_i
		elems = args[1].split(",").map{|el| el.to_i}
		
		colls = create_rows(elems, dim)
		colls += create_cols(colls)
		colls += create_squares(elems, dim)
		
		valid = true
		valid_elems = (1..dim).to_a
		colls.each do |coll|
			valid = is_valid(coll, valid_elems)
			break if !valid
		end
		
		puts valid.to_s.capitalize
	end
end