$dict = Hash[(1..26).to_a.zip(("a".."z").to_a)]

def count_decode(arr)
	if arr.length == 0 
		return 1
	elsif arr.length == 1
		return ($dict.include?(arr[0]) ? 1 : 0)
	else
		result = 0
		
		if $dict.include?(arr[0])
			result += count_decode(arr[1..arr.length])
		end
		
		if $dict.include?(arr[0..1].join.to_i)
			result += count_decode(arr[2..arr.length])
		end
		
		return result
	end
end

File.open(ARGV[0]).each_line do |line|
    if line.strip.length > 0 
		elems = line.strip.chars.to_a.map{|el| el.to_i}
		
		puts count_decode(elems)
	end
end