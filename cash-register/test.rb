$bills = ["PENNY", 0.01, "NICKEL", 0.05, "DIME", 0.10, "QUARTER", 0.25, "HALF DOLLAR", 0.50, "ONE", 1.00, "TWO", 2.00, "FIVE", 5.00, "TEN", 10.00, "TWENTY", 20.00, "FIFTY", 50.00, "ONE HUNDRED", 100.00]

$bills.reverse!

def give_change(bills, remaining, size, denom_string)
	if remaining >= size 
		remaining = remaining - size
		bills.push(denom_string)
	end	
	
	return remaining.round(2)
end

File.open(ARGV[0]).each_line do |line|
	args = line.split(";")
	cost = args[0].to_f
	tendered = args[1].to_f
	change = (tendered - cost).round(2)
	if change < 0
		puts "ERROR"
	elsif change == 0
		puts "ZERO"
	else
		given = []
		$bills.each_slice(2) do |slice|
			change = give_change(given, change, slice[0], slice[1])
		end
		puts given.join(",")
	end
end