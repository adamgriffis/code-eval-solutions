def get_ciphers(key)
	keyStr = key
	ciphers = []
	power = 1
	powerIndex = 0
	ciphers[0] = []
	while keyStr.length > 0 
		char = keyStr[0]
		keyStr = keyStr[1..keyStr.length]
		
		if powerIndex > (2**power - 2)
			power += 1
			powerIndex = 0
			ciphers[power-1] = []
		end
		
		ciphers[power-1][powerIndex] = char
		powerIndex += 1
	end
	
	return ciphers
end

def decode_portion(portion_length, cipher, messageList)
	result = ""
	
	while messageList.length > 0
		msg_seg = messageList.shift(portion_length).join("")
		msg_int = msg_seg.to_i(2)
		#puts "message segment: " + msg_seg
		#puts "message int: " + msg_int.to_s
		#puts "result: " + result
		
		if msg_int == (2**(portion_length)-1) #if the string is all 1s
			break
		else
			result += cipher[msg_int]
		end
	end
	
	return result
end

def decode_message(messageList, ciphers)
	result = ""
	while messageList.length > 0
		portion_key = messageList.shift(3)
		portion_key = portion_key.join("")
		#puts "Portion Key: " + portion_key
		if portion_key == "000"
			break
		end
		
		portion_length = portion_key.to_i(2)
		#puts "Portion Length: " + portion_length.to_s
		#puts "Cipher: " + ciphers[portion_length-1].join(",")
		result += decode_portion(portion_length, ciphers[portion_length-1], messageList)
	end
	return result
end

File.open(ARGV[0]).each_line do |line|
	line.strip!
	
    first_zero = line.index("0")
	key = line[0..first_zero-1]
	message = line[first_zero..line.length-1]
	
	#puts "key: " + key
	#puts "message: " + message
	
	ciphers = get_ciphers(key)
	
=begin 
	ciphers.each_index do |cipher_idx|
		#puts (cipher_idx + 1).to_s + " length strings: "
		ciphers[cipher_idx].each_index do |idx| 
			puts idx.to_s(2) + ": " + ciphers[cipher_idx][idx]
		end
	end
=end
	
	puts decode_message(message.chars.to_a, ciphers)
end