def num_for_word(word)
	case word
	when "zero"
		0
	when "one"
		1
	when "two"
		2
	when "three"
		3
	when "four"
		4
	when "five"
		5
	when "six"
		6
	when "seven"
		7
	when "eight"
		8
	when "nine"
		9
	end
end

File.open(ARGV[0]).each_line do |line|
	rst = ""
	line.strip.split(";").each do |word|
		rst = rst + num_for_word(word).to_s
	end
	
	puts rst
end