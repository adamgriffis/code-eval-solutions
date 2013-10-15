def clean_string(line)
	return line.strip.gsub(/[^a-zA-Z]/, "").downcase # replace all non-alphabetical characters with an empty space, then downcase it (we don't care about space)
end

$alpha = *("a".."z")

File.open(ARGV[0]).each_line do |line|
	line = clean_string(line)
	chars = line.chars.to_a.uniq
	missing = $alpha - chars
	puts missing.sort.join("") if missing.length > 0 
	puts "NULL" if missing.length == 0
end