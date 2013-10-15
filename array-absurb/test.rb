File.open(ARGV[0]).each_line do |line|
	if (line.strip).length > 0
		args = line.strip.split(";")
		size = args[0].to_i
		if size > 1
			arr = Array.new(size-1) {0}
		end
		
		elems = args[1].split(",")
		elems.each do |el|
		   i = el.to_i
		   if arr[i] > 0 
			   puts i
			   break
		   else
			   arr[i] = 1
		   end
		end
	end
end