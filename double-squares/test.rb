def count_dbl_sqrs(m)
   return 1 if m == 0
   return 1 if m == 1
   cnt = 0
   limit = (Math.sqrt(m/2)).to_i
   
   (0..limit).each do |i|
      j = Math.sqrt(m - i**2)
      if j == j.to_i
		cnt = cnt + 1
	  end
   end
   
   return cnt
end

n = -1
File.open(ARGV[0]).each_line do |line|
    break if n == 0
    if n == -1
        n = line.to_i
    else
        puts count_dbl_sqrs(line.to_i)
        n = n - 1
    end
end