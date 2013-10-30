File.open(ARGV[0]).each_line do |line|
    puts !(line.strip =~ /^([^ @"<>]+|".*")@([a-z1-9.])+.([a-z])+$/i).nil?
end