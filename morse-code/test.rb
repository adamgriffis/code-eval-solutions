$alphabet = 
{".-" => "A",
 "-..." => "B",
 "-.-." => "C",
 "-.." => "D",
 "." => "E",
 "..-." => "F",
 "--." => "G",
 "...." => "H",
 ".." => "I",
 ".---" => "J",
 "-.-" => "K",
 ".-.." => "L",
 "--" => "M",
 "-." => "N",
 "---" => "O",
 ".--." => "P",
 "--.-" => "Q",
 ".-." => "R",
 "..." => "S",
 "-" => "T",
 "..-" => "U",
 "...-" => "V",
 ".--" => "W",
 "-..-" => "X",
 "-.--" => "Y",
 "--.." => "Z",
 ".----" => "1",
 "..---" => "2",
 "...--" => "3",
 "....-" => "4",
 "....." => "5",
 "-...." => "6",
 "--..." => "7",
 "---.." => "8",
 "----." => "9",
 "-----" => "0"}
 
 def translate_word(letters)
	result = ""
	letters.each do |letter|
		puts letter if $alphabet[letter].nil?
		result += $alphabet[letter]
	end
	
	return result
 end
 
 File.open(ARGV[0]).each_line do |line|
    line.strip!
	words = line.split("  ")
	words_tran = []
	
	words.each do |word|
		words_tran.push(translate_word(word.split(" ")))
	end
	
	puts words_tran.join(" ")
end