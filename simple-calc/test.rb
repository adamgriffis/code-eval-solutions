File.open(ARGV[0]).each_line do |line|
	line = line.strip.gsub(/(?<!\.)(?<!\d)((\-)?\d+)(?!\.)(?!\d)/, '\1.0').gsub("^","**")
	result = eval(line)
	result = result.to_i if result.to_i == result.to_f
	result = result.round(5) if result.to_i != result.to_f
	puts result
end