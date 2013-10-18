$hash_assoc = {}

def build_assoc(arr)
	arr.sort! 
	arr.map!{|elem| elem.strip}
	return if arr[0] == arr[1]
	$hash_assoc[arr[0]] = {} if $hash_assoc[arr[0]].nil?
	$hash_assoc[arr[0]][arr[1]] = 0 if $hash_assoc[arr[0]][arr[1]].nil?
	$hash_assoc[arr[0]][arr[1]] += 1
end

def get_elems
	result = []
	result += $hash_assoc.keys
	
	$hash_assoc.each_value {|value| result += value.keys}
	
	return result.uniq.sort
end

def get_associated(a, b)
	if !$hash_assoc[a].nil? && !$hash_assoc[a][b].nil? && $hash_assoc[a][b] > 0
		return true
	end
	
	return false
end

def grow_subset(elems, subset)
	remaining = elems - subset
	result = subset
	
	remaining.each do |elem| 
		can_include = true
		subset.each do |subset_elem|
			if !get_associated(elem, subset_elem)
				can_include = false
				break
			end
		end
		result.push(elem) if can_include
	end
	
	return result
end

def subset_contained(subsets, subset_can)
	subsets.each do |subset|
		return true if (subset_can - subset).length == 0
	end
	
	return false
end

def build_subsets(elems)
	subsets = []
	(0..(elems.length-2)).each do |idx|
		a = elems[idx]
		
		(idx..(elems.length-1)).each do |idx2|
			b = elems[idx2]
			if get_associated(a, b)
				subset_candidate = [a,b]
				
				if !subset_contained(subsets, subset_candidate)
					subset = grow_subset(elems, subset_candidate)
					subsets.push(subset) if subset.length > 2
				end
			end
		end
	end
	
	return subsets
end

File.open(ARGV[0]).each_line do |line|
    elems = line.strip.split(" ")
	build_assoc(elems[elems.length-2..elems.length-1])
end

#puts $hash_assoc
elems = get_elems
#puts elems.join(",")
#puts grow_subset(elems, elems[0..1]).join(",")
subsets = build_subsets(elems)
subsets.map! {|subset| subset.sort.join(", ")}
subsets.sort.each do |subset|
	puts subset
end