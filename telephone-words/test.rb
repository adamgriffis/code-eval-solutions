$keys = {0 => "0".chars.to_a,
1 => "1".chars.to_a,
2 => "abc".chars.to_a,
3 => "def".chars.to_a,
4 => "ghi".chars.to_a,
5 => "jkl".chars.to_a,
6 => "mno".chars.to_a,
7 => "pqrs".chars.to_a,
8 => "tuv".chars.to_a,
9 => "wxyz".chars.to_a}

def build_words(nums, str)
	if nums.length == 0
		$words.push(str)
	else
		nums_remain = nums[1..(nums.length-1)]
		$keys[nums[0]].each do |char|
			build_words(nums_remain, str+char)
		end
	end
end

File.open(ARGV[0]).each_line do |line|
    line.strip!
	nums = line.chars.to_a
	$words = []
	nums.map!{|char| char.to_i}
	build_words(nums,"")
	
	puts $words.sort.join(",")
end