
def count_paths(step)
	if step <= 0
		return 0
	elsif step == 1
		return 1
	elsif step == 2
		return 2
	else
		return count_paths(step-1) + count_paths(step-2)
	end
end

File.open(ARGV[0]).each_line do |line|
    line.strip!
	
	puts count_paths(line.to_i)
end