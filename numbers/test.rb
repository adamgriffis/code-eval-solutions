$num_strings = {"zero" => 0,
				"one" => 1,
				"two" => 2,
				"three" => 3,
				"four" => 4,
				"five" => 5,
				"six" => 6,
				"seven" => 7,
				"eight" => 8,
				"nine" => 9,
				"ten" => 10,
				"eleven" => 11,
				"twelve" => 12,
				"thirteen" => 13,
				"fifteen" => 15,
				"eighteen" => 18,
				"twenty" => 20,
				"thirty" => 30,
				"eighty" => 80,
				"forty" => 40,
				"fifty" => 50,
				"sixty" => 60,
				"seventy" => 70,
				"ninety" => 90} #fourteen, sixteen and seventeen can be deduced
				
$pow_strings = {"hundred" => 100,
				"thousand" => 1000,
				"million" => 1000000,
				"billion" => 1000000000}
				
def num_value(str)
	value = $num_strings[str]
	if value.nil? 
		value = $num_strings[str.sub("teen","")]
		value += 10 unless value.nil?
	end
	
	return value
end

def is_number?(str)
	return false if str.nil?
	return !num_value(str).nil?
end

def power_value(str)
	return $pow_strings[str]
end

def is_power?(str)
	return false if str.nil?
	return !$pow_strings[str].nil?
end

File.open(ARGV[0]).each_line do |line|
	number = 0
	#puts line
	elems = line.strip.gsub(" and "," ").split(" ")
	
	idx = 0
	#puts line
	#puts elems.join(",")
	idx = 1 if elems[0] == "negative"
	
	min_mil_idx = elems.rindex("million")
	min_thousand_idx = elems.rindex("thousand")
	min_hun_idx = elems.rindex("hundred")
	
	min_mil_idx = -1 if min_mil_idx.nil?
	min_thousand_idx = -1 if min_thousand_idx.nil? || min_thousand_idx < min_mil_idx
	min_hun_idx = elems.length+1 if min_hun_idx.nil? || min_hun_idx < min_thousand_idx || min_hun_idx < min_mil_idx
	min_mil_idx = elems.length+1 if min_mil_idx == -1
	min_thousand_idx = elems.length+1 if min_thousand_idx == -1
	
	pos_num = 0
	while idx < elems.length
		str = elems[idx]
		#puts line
		#puts "Str: " + str.to_s + " index: " + idx.to_s
		#puts "min mil idx: " + min_mil_idx.to_s
		#puts "min thou idx: " + min_thousand_idx.to_s
		#puts "min hun idx: " + min_hun_idx.to_s
		
		if idx == min_mil_idx 
			pos_num *= 1000000
			number += pos_num
			pos_num = 0
			idx += 1
			str = elems[idx]
			min_mil_idx = elems.length + 1
		end
		
		if idx == min_thousand_idx
			pos_num *= 1000
			number += pos_num
			pos_num = 0
			idx += 1
			str = elems[idx]
			min_thousand_idx = elems.length + 1
		end
		
		if idx == min_hun_idx
			pos_num *= 100
			number += pos_num
			pos_num = 0
			idx += 1
			str = elems[idx]
			min_hun_idx = elems.length + 1
		end
		
		while is_number?(str)
			pos_num += num_value(str)
			idx += 1
			str = elems[idx]
		end
		
		while is_power?(str) && idx < min_mil_idx && idx < min_hun_idx && idx < min_thousand_idx 
			pos_num *= power_value(elems[idx])
			idx += 1
			str = elems[idx]
		end
	end
	
	number += pos_num
	
	number *= -1 if elems[0] == "negative" 
	
	puts number
end