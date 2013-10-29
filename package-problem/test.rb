# we use a DP to solve this, after we've multiplied all the weights by 100 to 
# force them to be integers
def find_max_pack(values, weights, n, capacity)
	m_v = Array.new(n) {Array.new(capacity+1) {0} }
	m_i = Array.new(n) {Array.new(capacity+1) {[]} }
	m_w = Array.new(n) {Array.new(capacity+1) {0} }
	
	(0..n-1).each do |i|
		(0..capacity).each do |j|
			if j > weights[i] then
				# we could possible accommodate this item, should we?
				v_incl = m_v[i-1][j-weights[i]] + values[i]
				
				if v_incl > m_v[i-1][j] 
					# include 
					m_v[i][j] = v_incl
					m_i[i][j] = m_i[i-1][j-weights[i]] + [i+1]
				else
					# don't
					m_v[i][j] = m_v[i-1][j]
					m_i[i][j] = m_i[i-1][j]
				end
			else 
				m_v[i][j] = m_v[i-1][j]
				m_i[i][j] = m_i[i-1][j]
			end
		end
	end
	
	max_val = m_v[n-1][capacity]
	
	# find the minimum weight that supports the given value
	(0..capacity).each do |j|
		return m_i[n-1][j] if m_v[n-1][j] == max_val
	end
end

File.open(ARGV[0]).each_line do |line|
	line.strip!
	next if line.length == 0
	
	args = line.split(":")
	capacity = args[0].to_i
	
	item_str = args[1]
	item_str.gsub!(/(\(|\)|\$)/,"")
	item_str.gsub!(",", " ")
	items = item_str.split(" ")
	
	weights = []
	values = []
	
	items.each_slice(3) do |slice|
		weights.push((slice[1].to_f).round(0))
		values.push(slice[2].to_i)
	end
	
	packs = find_max_pack(values, weights, values.length, capacity)
	
	#puts weights.join("\t")
	#puts values.join("\t")
	puts packs.join(",") if packs.length > 0
	puts "-" if packs.length == 0
end