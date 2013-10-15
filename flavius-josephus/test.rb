File.open(ARGV[0]).each_line do |line|
    if line.strip.length > 0 
		args = line.split(",")
		n = args[0].to_i
		m = args[1].to_i
		
		alive = (0..(n-1)).to_a
		dead = []
		idx = -1
		while dead.length != n
			count_up = 0
			while count_up < m 
				idx += 1
				idx = idx % alive.length
				count_up += 1 if alive[idx] != -1
			end
			
			dead.push(alive[idx])
			alive[idx] = -1
		end
		puts dead.join(" ")
	end
end