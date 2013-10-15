class TriangleTreeNode 
	attr_accessor :val, :level, :index
	
	def initialize(val, level, index)
		@val = val
		@level = level
		@index = index
		@lchild = nil
		@rchild = nil
		@max = nil
	end
	
	def add(node)
		if node.level == (@level + 1)
			# this node is from the level elow me in the triangle, add it to my left or right branch, dependeing on the index
			@lchild = node if node.index == @index
			@rchild = node if node.index == (@index+1)
		else
			if (@index - node.index).abs <= (@level - node.level).abs
				@lchild.add(node) unless @lchild.nil?
				@rchild.add(node) unless @rchild.nil?
			end
		end
		
	end
	
	def max_path
		return @max unless @max.nil?
		
		lpath = 0
		rpath = 0
		
		lpath = @lchild.max_path unless @lchild.nil?
		rpath = @rchild.max_path unless @rchild.nil?
		
		@max = @val + [lpath, rpath].max
		return @max
	end
end

tree = nil
level = 0
File.open(ARGV[0]).each_line do |line|
	elems = line.strip.split(" ").map{|el| el.to_i}
	
	if tree.nil?
		tree = TriangleTreeNode.new(elems[0], level, 0)
	else
		# there is an existing tree, this is level 2 or lower
		elems.each_index do |idx| 
			node = TriangleTreeNode.new(elems[idx], level, idx)
			tree.add(node) 
		end
	end
	
	level += 1
end

puts tree.max_path