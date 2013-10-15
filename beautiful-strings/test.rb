def clean_string(line)
	return line.gsub(/[^a-zA-Z]/, "").downcase # replace all non-alphabetical characters with an empty space, then downcase it (we don't care about space)
end

class CharCount
	attr_accessor :char, :count
end

File.open(ARGV[0]).each_line do |line|
	line = clean_string(line)
	char_counts = []
	line.chars.to_a.uniq.each do |char| 
		cc = CharCount.new
		cc.char = char
		cc.count = line.count(char)
		
		char_counts.push(cc)
	end
	
	# sort by the instances of a each car, descending
	char_counts.sort_by! { |cc| cc.count }.reverse!
	
	sum = 0
	char_counts.each_index do |idx| 
		sum = sum + (26-idx)*char_counts[idx].count
	end
	
	puts sum
end