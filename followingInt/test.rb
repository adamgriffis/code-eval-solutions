def next_digit_increase(nums)
	num_zeros = nums.count(0)
	# next, strip out all of the zeros
	nums.delete(0)
	nums.sort!
	
	(1..(num_zeros+1)).each do |i|	
		nums.insert(1, 0)
	end
	
	return nums.join('')
end

def swap?(nums)
	#it's easier to just reverse the array, so we can iterate up
	nums.reverse!
	
	(1..(nums.length-1)).each do |idx1|
		(0..(idx1-1)).each do |idx2|
			if nums[idx1] < nums[idx2] 
				swp = nums[idx1]
				nums[idx1] = nums[idx2]
				nums[idx2] = swp
				
				arr1 = nums[0..(idx1-1)]
				arr1.sort!.reverse!
					
				arr2 = nums[(idx1)..(nums.length-1)]
				
				arr1.push(*arr2)
				
				puts arr1.reverse.join('')
				return true
			end
		end
	end
	
	return false
end

File.open(ARGV[0]).each_line do |line|
    nums = line.strip.chars.map {|el| el.to_i}
	
	if nums.length > 0 
		puts next_digit_increase(nums) unless swap?(nums)
	end
end