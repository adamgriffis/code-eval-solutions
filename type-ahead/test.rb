$msg = 'Mary had a little lamb its fleece was white as snow; And everywhere that Mary went, the lamb was sure to go.  *It followed her to school one day, which was against the rule; It made the children laugh and play, to see a lamb at school. And so the teacher turned it out, but still it lingered near, And waited patiently about till Mary did appear. "Why does the lamb love Mary so?" the eager children cry;"Why, Mary loves the lamb, you know" the teacher did reply."'
$msg_arr = $msg.gsub(/[^A-Za-z]/, " ").split(" ")

def find_sub_arr_idxes(arr, sub_arr)
	result = []
	arr.each_index do |idx|
		if arr[idx] == sub_arr[0] 
			if arr[idx..(idx+(sub_arr.length-1))] == sub_arr
				result.push(idx)
			end
		end
	end
	
	return result
end

def get_probability_hash(key_arr, remaining_length)
	sub_arr_idxes = find_sub_arr_idxes($msg_arr, key_arr)
	result = {}
	total_count = 0
	
	sub_arr_idxes.each do |idx|
		if idx < ($msg_arr.length - key_arr.length)
			total_count += 1
			string = $msg_arr[(idx+key_arr.length)..(idx+key_arr.length+remaining_length-1)].join(" ")
			result[string] = 0 if result[string].nil?
			result[string] += 1 
		end
	end
	
	result.each_key do |key| 
		result[key] = (result[key].to_f / total_count).round(3)
	end
	
	return result
end

def get_result_string(hash)
	arr = hash.to_a
	arr.sort! do |a,b|
		result = (a[1] <=> b[1])*-1
		result = a[0] <=> b[0] if result == 0
		result
	end
	
	arr.map! do |sub_arr| 
		sub_arr[1] = "%.3f" % sub_arr[1]
		sub_arr.join(",")
	end
	return arr.join(";")
end

File.open(ARGV[0]).each_line do |line|
    args = line.strip.split(",")
	length = args[0].to_i
	msg_elems = args[1].split(" ")
	
	hash = get_probability_hash(msg_elems, length - msg_elems.length)
	puts get_result_string(hash)
end