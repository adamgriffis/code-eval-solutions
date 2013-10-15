n = -1
lines = []

File.open(ARGV[0]).each_line do |line|
	if n < 0 
		n = line.strip.to_i
	else
		lines.push(line.strip)
	end
end

lines = lines.sort_by{|word| word.length}.reverse
puts lines[0..(n-1)].join("\n")