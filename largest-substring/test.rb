class Node
	attr_accessor :index, :length, :children, :edge, :parent, :avail
	
	def initialize(index, edge, parent_length, parent)
		@index = index
		@length = parent_length 
		@length += edge.length if !edge.nil?
		@children = []
		@edge = edge 
		@parent = parent
		@avail = true
	end
	
	def find_max_interior_depth
		result = nil
		
		@children.each do |child|
			cand = child.find_max_interior_depth
			if !cand.nil? && (result.nil? || cand > result)
				result = cand
			end
		end
		
		if result.nil? 
			if @children.length > 0 && @length > 0 && @avail
				result = @length
			end
		end
		
		return result
	end
	
	def find_of_depth(depth)
		result = []
		
		puts "Edge: " + @edge.to_s
		puts "Length: " + @length.to_s
		puts "children: " + @children.length.to_s
		puts "Avail: " + @avail.to_s
		if @children.length > 0 && @length == depth && @avail
			result.push(self)
		else 
			@children.each do |child|
				result += child.find_of_depth(depth)
			end
		end
		
		return result
	end
	
	def add_node(string, index)
		#print_self
		#puts "Adding: " + string.to_s
		
		found = false
		children.each do |child|
			if string[0] == child.edge[0]
				idx = 0
				while string[0..idx] == child.edge[0..idx] && idx < child.edge.length
					idx += 1
				end
				
				#puts "Common prefix found: " + child.edge[0..idx-1]
				
				# this edge isn't entirely consumed, split it
				if idx < child.edge.length
					new_node = Node.new(nil, child.edge[0..idx-1], @length, self)
					#puts "Split edge: " + new_node.edge
					child.edge = child.edge[idx..child.edge.length-1]
					child.parent = new_node
					#puts "Child 1 edge: " + child.edge
					
					new_node.children.push(child)
					@children.delete(child)
					@children.push(new_node)
					
					new_child = Node.new(index, string[idx..string.length - 1], new_node.length, new_node)
					new_node.children.push(new_child)
					#puts "Child 2 edge: " + new_child.edge
					#puts "Creating new child: "
					#new_child.print_self
				else
					#puts "Adding node: " + string[idx..string.length-1].to_s
					child.add_node(string[idx..string.length - 1], index)
				end
				return
			end
		end
		
		# no matching edges were found, create an entirey new node
		new_node = Node.new(index, string, @length, self)
		children.push(new_node)
	end
	
	def print_self
		puts "Edge: " + @edge.to_s
		puts "Index: " + @index.to_s
		puts "Length: " + @length.to_s
		puts "Children: " + @children.length.to_s
		if !@parent.nil?
			puts "Parent: " + @parent.edge.to_s unless @parent.edge.nil?
			puts "Parent: ROOT" if @parent.edge.nil?
		end
		puts "ROOT" if @parent.nil?
	end
	
	def get_string
		result = ""
		result = parent.get_string unless parent.nil?
		result += self.edge.to_s
		return result
	end
	
	def print_tree
		# print yourself, then your children 
		print_self
		
		children.each do |child|
			child.print_tree
		end
	end
end

def create_suffix_tree(string)
	root = Node.new(nil, nil, 0, nil)
	string += "$"
	
	(0..string.length-1).each do |idx|
		root.add_node(string[idx..string.length-1], idx)
	end
	
	#puts "===================="
	
	#root.print_tree
	return root
end

File.open(ARGV[0]).each_line do |line|
	#puts line
	tree = create_suffix_tree(line.strip)
	#tree.print_tree
	max_node_depth = tree.find_max_interior_depth
	while !max_node_depth.nil? && max_node_depth > 0 
		nodes = tree.find_of_depth(max_node_depth)
		puts "Find of depth: " + max_node_depth.to_s
		
		nodes.reject! do |node|
			result = false
			sub_str = node.get_string
			if line.scan(sub_str).size <= 1 || sub_str.strip.length == 0
				node.avail = false
				result = true
			end
			
			puts "Considering: " + sub_str
			puts "Result: " + result.to_s
			
			result
		end
		
		# stop if we still have nodes left
		break if nodes.length > 0 
		max_node_depth = tree.find_max_interior_depth
	end
	
	sub_str = nil
	if nodes.length > 0
		min_idx = line.length + 1 
		
		nodes.each do |node|
			str = node.get_string
			idx = line.index(str)
			
			puts "Str: " + str
			puts "Idx: " + idx.to_s
			
			if idx < min_idx
				min_idx = idx
				sub_str = str
			end
		end
	end
	
	puts sub_str unless sub_str.nil?
	puts "NONE" if sub_str.nil?
	
end