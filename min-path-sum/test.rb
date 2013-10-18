$infinity = -1

class Grid
	def initialize(size)
		@size = size
		@matrix = Array.new(size) {Array.new(size) { nil} }
		@costs = Array.new(size) {Array.new(size) { $infinity }}
		@visited = Array.new(size) {Array.new(size) { false }}
	end
	
	def add_row(row_idx, line)
		elems = line.split(",")
		
		(0..@size-1).each do |col_idx| 
			@matrix[row_idx][col_idx] = elems[col_idx].to_i
		end
	end
	
	def get_adjacent_nodes(node)
		nodes = [[node[0]-1, node[1]],
				 [node[0]+1, node[1]],
				 [node[0], node[1]-1],
				 [node[0], node[1]+1]]
				 
		nodes.select {|node| node[0] >= 0 && node[1] >= 0 && node[0] < @size && node[1] < @size}
	end
	
	def print_grid(grid)
		grid.each do |row|
			puts row.join(" ")
		end
	end
	
	def print_all
		puts "Source Matrix: "
		print_grid(@matrix)
		puts "==============="
		puts "Cost Matrix: "
		print_grid(@costs)
		puts "==============="
		puts "Visited Matrix: "
		print_grid(@visited)
		puts "==============="
	end
	
	# if we assume the numbers in each grid are the costs of all
	# edges incoming to the square, and then treat each square as
	# a node connected to all squares above, below and to the left
	# and right, then we can just apply Dijkstra's to find it
	def find_costs
		# initialize the cost of the first cell to its cost
		@costs[0][0] = @matrix[0][0]
		
		node_queue = [[0,0]]
		while !node_queue.empty?
			curr_node = node_queue.shift()
			adjacent_nodes = get_adjacent_nodes(curr_node)
			min_adjacent_cost = $infinity
			min_adjacent = nil
			
			curr_cost = @costs[curr_node[0]][curr_node[1]]
			
			adjacent_nodes.each do |node|
				path_cost = curr_cost + @matrix[node[0]][node[1]]
				if @costs[node[0]][node[1]] == $infinity || @costs[node[0]][node[1]] > path_cost
					@costs[node[0]][node[1]] = path_cost
				end
				
				node_queue.push(node) unless @visited[node[0]][node[1]]
			end
			
			@visited[curr_node[0]][curr_node[1]] = true
			curr_node = min_adjacent
		end
		
		return @costs[@size -1][@size -1]
	end
end

size = nil
grid = nil
idx = 0

File.open(ARGV[0]).each_line do |line|
    line.strip!
	
	if size == 0 
		puts grid.find_costs
		#puts grid.print_all
		size = nil
		idx = 0
	end
	
	if size.nil? 
		size = line.to_i
		grid = Grid.new(size)
	else
		grid.add_row(idx, line)
		idx += 1
		size -= 1
	end
end

puts grid.find_costs