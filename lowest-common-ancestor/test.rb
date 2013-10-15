class BTreeNode 
	def initialize(val)
		@val = val
		@lchild = nil
		@rchild = nil
	end
	
	def add(newVal)
		if newVal < @val 
			if @lchild.nil?
				@lchild = BTreeNode.new(newVal)
			else
				@lchild.add(newVal)
			end
		else
			if @rchild.nil?
				@rchild = BTreeNode.new(newVal)
			else
				@rchild.add(newVal)
			end
		end
	end
	
	def find_path(val)
		if val == @val 
			return [val]
		else
			path = nil
			
			if val < @val && !@lchild.nil?
				path = @lchild.find_path(val)
			end
			
			if val > @val && !@rchild.nil?
				path = @rchild.find_path(val)
			end
			
			path.unshift(@val) unless path.nil?
			
			return path
		end
	end
end

def build_tree
	root = BTreeNode.new(30)
	root.add(8)
	root.add(3)
	root.add(20)
	root.add(10)
	root.add(29)
	root.add(52)
	
	return root
end

$tree = build_tree
File.open(ARGV[0]).each_line do |line|
	args = line.strip.split(" ")
	
	path1 = $tree.find_path(args[0].to_i)
	path2 = $tree.find_path(args[1].to_i)
	lca = nil
	if !path1.nil? 
		path1.each_index do |idx| 
			lca = path1[idx] if (path1[idx] == path2[idx])
			break if (path1[idx] != path2[idx])
		end
	end
	
	puts lca
end