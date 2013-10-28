def longest_common_prefix(s1, s2, max=nil)
	min = [s1.size, s2.size, max].compact.min
	min.times do |i|
		return s1.slice(0,i) if s1[i] != s2[i] # when we don't have a common prefix, 
											# return the last i letters starting at 0
	end
	
	return s1.slice(0,min) # all of one of the strings, or up to max have matched
end

def longest_repeated_substring(string)
	size = string.length
	
	# create an array of suffixes
	suffixes = Array.new(size)
	size.times do |i|
		suffixes[i] = string.slice(i, size)
	end
	
	#sort them
	suffixes.sort!
	
	best = ""
	at_least_size = 1 #the size to meet or exceed to be the new best
	distance = nil 
	neighbors_to_check = 1
	
	(0..size-1).each do |i|
		s1 = suffixes[i]
		
		neighbors_to_check.downto(1) do |neighbor|
			s2 = suffixes[i-neighbor]
			next if s2.nil?
			
			#puts "i: " + i.to_s
			#puts "neighbor: " + neighbor.to_s
			#puts "s1: " + s1.to_s + " s2: " + s2.to_s
			#puts suffixes.length
			distance = (s1.size - s2.size).abs
			if distance < at_least_size # just prune out considerations we know won't yield
				if s1.size >= at_least_size &&
					s2.size >= at_least_size && #when we have an overlap, extend our considered neighbors
					s1.slice(0, at_least_size) == s2.slice(0, at_least_size)
					neighbors_to_check = [neighbors_to_check, neighbor+1].max
				else
					neighbors_to_check = neighbor
				end
				next
			end
			
			# if our two strings match at least as many characters as we already
			# know is our best, we can continue, otherwise let's just skip to the next one
			unless s1.slice(0, at_least_size) == s2.slice(0, at_least_size)
				neighbors_to_check = neighbor
				next
			end
			
			best = longest_common_prefix(s1, s2, distance)
			at_least_size = best.size + 1
			if best.size == distance
				neighbors_to_check = [neighbors_to_check, neighbor+1].max
			else
				neighbors_to_check = neighbor
			end 
		end
	end
	
	best
end

File.open(ARGV[0]).each_line do |line|
	line.strip!
	
	sub_str = longest_repeated_substring(line)
	
	puts sub_str unless sub_str.nil? || sub_str.strip.length == 0
	puts "NONE" if sub_str.nil? || sub_str.strip.length == 0 
	
end
	