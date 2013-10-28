require 'set'

$infinity = 999999

def gcd(num1, num2)
	return num1 if num1 == num2
	larger = (num1 > num2 ? num1 : num2)
	smaller = (num1 < num2 ? num1 : num2)
	remainder = larger % smaller
	divisor = larger / smaller
	while remainder != 0 
		larger = smaller
		smaller = remainder
		
		remainder = larger % smaller
		divisor = larger / smaller
	end
	
	return smaller
end

def count_letters(string)
	string.scan(/[A-Za-z]/).size
end

def count_vowels(string)
	string.scan(/[AEIOUYaeiouy]/).size
end

def count_constanants(string)
	string.downcase.scan(/[bcdfghjklmnpqrstvwxz]/).size
end

def is_even(num)
	num % 2 == 0 
end

def calc_ss(product, customer)
	letters_product = count_letters(product)
	letters_customer = count_letters(customer)
	ss = 0
	if is_even(letters_product)
		ss = count_vowels(customer) * 1.5
	else 
		ss = count_constanants(customer) 
	end
	
	if gcd(letters_product, letters_customer) > 1 
		ss *= 1.5
	end 
	
	return ss
end

class CustomerProductMatrix
	def initialize(customers, products)
		@cust_count = customers.length
		@prod_count = products.length
		@dim = @cust_count > @prod_count ? @cust_count : @prod_count
		@customer_product = []
		
		min_ss = -1
		
		customers.each do |cust|
			prod_ss = []
			products.each do |prod|
				ss = calc_ss(prod, cust)
				if ss < min_ss || min_ss == -1
					min_ss = ss
				end
				prod_ss.push(ss)
			end
			(prod_ss.length..@dim-1).each do |idx|
				prod_ss.push(0) #square the matrix
			end
			@customer_product.push(prod_ss)
		end
		
		(customers.length..@dim-1).each do |idx|
			@customer_product.push(Array.new(@dim) {0})
		end
	end
	
	def print_matrix
		@customer_product.each do |cust_row|
			puts cust_row.join("\t")
		end
	end
	
	def print_work
		@work_cp.each do |row|
			puts row.join("\t")
		end
	end
	
	def create_work_matrix
		result = []
		
		(0..@dim-1).each do |row|
			rowObj = []
			(0..@dim-1).each do |col|
				val = @customer_product[row][col]
				rowObj.push(val * -1) #negate all columns 
			end
			result.push(rowObj)
		end
		
		return result
	end
	
	def reduce_matrix
		min_ss = $infinity
		
		(0..@dim-1).each do |row|
			(0..@dim-1).each do |col|
				if min_ss == $infinity || min_ss > @work_cp[row][col]
					min_ss = @work_cp[row][col]
				end
			end
		end
		
		(0..@dim-1).each do |row|
			(0..@dim-1).each do |col|
				@work_cp[row][col] -= min_ss
			end
		end
	end
	
	def calc_result(assignments)
		result = 0
		
		assignments.each do |assignment|
			result += @customer_product[assignment[0]][assignment[1]]
		end
		
		return result
	end
	
	def compute_assignments
		@work_cp = create_work_matrix
		reduce_matrix

		stars_by_row = Array.new(@dim) {-1}
		stars_by_col = Array.new(@dim) {-1}
		primes_by_row = Array.new(@dim) {-1}
		
		covered_rows = Array.new(@dim) {false}
		covered_cols = Array.new(@dim) {false}
		 
		init_stars(stars_by_row, stars_by_col)
		cover_columns_of_starred_zeros(stars_by_col, covered_cols)
		
		while !all_are_covered(covered_cols) do
			primed_zero = prime_some_uncovered_zero(primes_by_row, covered_rows, covered_cols)
			
			#puts "Prime Zero: " + primed_zero.join(",") unless primed_zero.nil?
			#puts "Prime Zero: nil" if primed_zero.nil?
			
			while primed_zero.nil?
				make_more_zeros(covered_rows, covered_cols)
				primed_zero = prime_some_uncovered_zero(primes_by_row, covered_rows, covered_cols)
			end
			
			#puts "Prime Zero: " + primed_zero.join(",") unless primed_zero.nil?
			#puts "Prime Zero: nil" if primed_zero.nil?
							
			#checked if there is a starred zero in the primed zeros row
			col_idx = stars_by_row[primed_zero[0]]
			#puts "Star by row: " + stars_by_row.join(",")
			if -1 == col_idx
				#increment the zeros and start over
				increment_set_of_starred_zeros(primed_zero, stars_by_row, stars_by_col, primes_by_row)
				primes_by_row.map!{|prime| -1}
				covered_rows.map!{|row| false}
				covered_cols.map!{|col| false}
				
				cover_columns_of_starred_zeros(stars_by_col, covered_cols)
			else
				#puts "Marking covered: " + primed_zero[0].to_s + "," + col_idx.to_s
				#cover the row of the primed zero and uncover the column of the starred zero in the same row
				covered_rows[primed_zero[0]] = true
				covered_cols[col_idx] = false
			end
		end
		
		result = []
		stars_by_col.each_index do |col| 
			result.push([stars_by_col[col], col])
		end
		
		return result
	end
	
	def init_stars(starsByRow, starsByCol)
		rowHasStarredZero = Array.new(@dim) {false}
		colHasStarredZero = Array.new(@dim) {false}
		
		#print_work
		
		(0..@dim-1).each do |row|
			(0..@dim-1).each do |col|
				if 0 == @work_cp[row][col] && !rowHasStarredZero[row] && !colHasStarredZero[col]
					starsByRow[row] = col
					starsByCol[col] = row
					#puts "Adding star: " + row.to_s + " , " + col.to_s
					rowHasStarredZero[row] = true
					colHasStarredZero[col] = true
					break
				end
			end
		end

=begin
		puts starsByRow.join(",")
		puts starsByCol.join(",")
		
		(0..@dim-1).each do |row|
			rowStr = ""
			(0..@dim-1).each do |col|
				unless starsByRow[row] == col
					rowStr += (" " + @customer_product[row][col].to_s)
				else
					rowStr += " *"
				end
			end
			#puts rowStr
		end
=end
	end
	
	def cover_columns_of_starred_zeros(starsByCol, coveredCols)
		(0..@dim-1).each do |idx|
			coveredCols[idx] = starsByCol[idx] >= 0
		end
	end
	
	def all_are_covered(coveredCols)
		coveredCols.each do |covered_col|
			return covered_col unless covered_col
		end
		return true
	end
	
	def prime_some_uncovered_zero(primes_by_row, covered_rows, covered_cols)
		#puts "Priming"
		#puts "Primes by row: " + primes_by_row.join(",")
		#puts "Covered rows: " + covered_rows.join(",")
		#puts "Covered cols: " + covered_cols.join(",")
		(0..@dim-1).each do |row|
			if !covered_rows[row]
				(0..@dim-1).each do |col|
					if @work_cp[row][col] == 0 && !covered_cols[col]
						primes_by_row[row] = col
						return [row,col]
					end
				end
			end
		end
		return nil
	end
	
	def make_more_zeros(covered_rows, covered_cols) 
		min_uncov_ss = $infinity
		
		#puts "Covered Rows: " + covered_rows.join(",")
		#puts "Covered Cols: " + covered_cols.join(",")
		
		(0..@dim-1).each do |row|
			if !covered_rows[row]
				(0..@dim-1).each do |col|
					if !covered_cols[col] && (@work_cp[row][col] < min_uncov_ss || min_uncov_ss == $infinity)
						min_uncov_ss = @work_cp[row][col]
					end
				end
			end
		end
		
		#puts "min uncovered ss: " + min_uncov_ss.to_s
		
		#add min to all covered rows
		(0..@dim-1).each do |row|
			if covered_rows[row]
				(0..@dim-1).each do |col|
					@work_cp[row][col] += min_uncov_ss
				end
			end
		end
		
		#subtract min from all uncovered cols 
		(0..@dim-1).each do |col|
			if !covered_cols[col]
				(0..@dim-1).each do |row|
					@work_cp[row][col] -= min_uncov_ss 
				end
			end
		end
		
		#print_work
	end
	
	def increment_set_of_starred_zeros(unpaired_zero_prime, stars_by_row, stars_by_col, primes_by_row)
		#puts "Increment set"
		#puts "primes by row: " + primes_by_row.join(",")
		#build alternating zero sequence
		row = -1
		col = unpaired_zero_prime[1]
		
		zero_seq = Set.new()
		zero_seq.add(unpaired_zero_prime)
		paired = false
		
		loop do 
			row = stars_by_col[col]
			paired = -1 != row && !zero_seq.add?([row,col]).nil?
			break if !paired
			
			col = primes_by_row[row] 
			paired = -1 != col && !zero_seq.add?([row,col]).nil?
			
			break if !paired
		end
		
		#puts "StarsByCol: " + stars_by_col.join(",")
		#puts "StarsByRow: " + stars_by_row.join(",")
		#puts "PrimesByRow: " + primes_by_row.join(",")
		
		#unstar each starred zero of the seq and star each primed zero
		zero_seq.each do |zero_pos|
			if stars_by_col[zero_pos[1]] == zero_pos[0]
				#puts "Removing star: " + zero_pos[1].to_s
				stars_by_col[zero_pos[1]] = -1
				stars_by_row[zero_pos[0]] = -1
			end
			
			#puts primes_by_row[zero_pos[0]]
			if primes_by_row[zero_pos[0]] == zero_pos[1] 
				stars_by_row[zero_pos[0]] = zero_pos[1]
				#puts "Adding star: " + zero_pos[0].to_s + " , " + zero_pos[1].to_s
				stars_by_col[zero_pos[1]] = zero_pos[0]
				#primes_by_row[zero_pos[0]] = -1
			end
		end
	end
end

File.open(ARGV[0]).each_line do |line|
	line.strip!
	elems = line.split(";")
	if elems.size < 2
		puts "0.00"
	else
		customers = elems[0].split(",")
		products = elems[1].split(",")
		
		#puts customers.join(",")
		#puts products.join(",")
		
		matrix = CustomerProductMatrix.new(customers, products)
		#matrix.print_matrix
		assignments = matrix.compute_assignments
		#puts assignments.map{|assignment| "[" + assignment.join(",") + "]"}.join(",")
		#matrix.print_matrix
		puts '%.2f' % matrix.calc_result(assignments)
		#puts matrix.find_max_ss(0)
	end
end