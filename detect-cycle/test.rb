class Array
	def all_indices(elem, startIdx)
		result = []
		self.each_index{|index| result.push(index) if index >= startIdx && self[index] == elem}
		return result
	end
end

def detect_cycle(elems, idx1, idx2)
	#puts "Detect Cycle: " + idx1.to_s + " , " + idx2.to_s
	arr1 = elems[idx1..idx2]
	#puts "arr1: " + arr1.join(",")
	arr2 = elems[idx2+1..(idx2+(idx2-idx1)+1)]
	#puts "arr2: " + arr2.join(",")
	
	arr1 == arr2
end

File.open(ARGV[0]).each_line do |line|
	elems = line.split(" ")
	cycle_found = false
	
	elems.each_index do |idx|
		char = elems[idx]
		
		idxs = elems.all_indices(char,idx+1)
		#puts "char: " + char
		#puts "idxs: " + idxs.join(",")
		idxs.each do |idx2|
			if detect_cycle(elems, idx, idx2-1)
				puts elems[idx..idx2-1].join(" ") 
				cycle_found = true
				break
			end
		end
		
		break if cycle_found
	end
end