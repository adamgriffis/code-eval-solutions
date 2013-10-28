$aces_high = true

$hand_rankings = 
{ :straight_flush => 10,
  :four_of_a_kind => 9,
  :full_house => 8,
  :flush => 7,
  :straight => 6,
  :three_of_a_kind => 5,
  :two_pair => 4,
  :pair => 3,
  :singleton => 1
}

$card_delim = " "

class Hand
	attr_accessor :cards, :type, :hand_val_determined
	def initialize(str)
		@cards = []
		card_strs = str.split($card_delim)
		#puts card_strs.join(",")
		card_strs.each do |card_str|
			#puts "Card String: " + card_str.to_s
			card = Card.new(card_str)
			#puts "New card: " + card.to_s
			cards.push(card)
		end
		@type = nil
		@hand_val_determined = false
		
		cards.sort_by! {|card| card.value}
	end
	
	def is_full_house?
		contains_3 = false
		contains_2 = false
		
		@pairing_map.each_value do |val|
			contains_3 = true if val == 3
			contains_2 = true if val == 2
		end
		
		return contains_3 && contains_2
	end
	
	def is_straight?
		prev_val = @cards[0].value
		
		(1..@cards.length-1).each do |idx|
			if @cards[idx].value == prev_val+1
				prev_val = @cards[idx].value
			else
				return false
			end
		end
		
		return true
	end
	
	def is_flush?
		suit = @cards[0].suit
		
		@cards.each do |card|
			return false if card.suit != suit
		end
	end
	
	def val_of_a_kind(num)
		max_pair_val = -1
		@pairing_map.each_key do |key|
			if @pairing_map[key] == num
				if key > max_pair_val
					max_pair_val = key
				end
			end
		end
		
		return max_pair_val 
	end
	
	def is_two_pair?
		pair_cnt = 0
		
		@pairing_map.each_value do |val|
			pair_cnt += 1 if val == 2 
		end
		
		return pair_cnt == 2
	end
	
	def is_of_a_kind?(num)
		return val_of_a_kind(num) > 0
	end
	
	def gen_pairing_map!
		@pairing_map = {}
		
		@cards.each do |card|
			if @pairing_map[card.value].nil?
				@pairing_map[card.value] = 0
			end
			
			@pairing_map[card.value] += 1
		end
	end
	
	def mark_all_used!
		@cards.each {|card| card.used = true}
	end
	
	def mark_all_vals_used!(val)
		@pairing_map[val] = 0
		@cards.each {|card| card.used = true if card.value == val}
	end
	
	def high_used_val?
		max_used = -1
		
		@cards.each do |card|
			if card.used && max_used < card.value 
				max_used = card.value
			end
		end
		
		return max_used
	end
	
	def high_unused_val?
		max_unused = -1
		
		@cards.each do |card|
			if !card.used && max_unused < card.value
				max_unused = card.value
			end
		end
		
		return max_unused
	end
	
	def used_cards?
		return @cards.reject {|card| !card.used }
	end
	
	def unused_cards?
		return @cards.reject {|card| card.used }
	end
	
	def higher_cards?(myCards, hisCards)
		myCards.each_index do |idx|
			myCard = myCards[myCards.length - idx - 1]
			hisCard = hisCards[hisCards.length - idx - 1]
			
			if myCard.value > hisCard.value
				return 1
			end
			
			if myCard.value < hisCard.value
				return -1
			end
		end
		
		return 0
	end
	
	def determine_hand_value!
		gen_pairing_map!
		@hand_val_determined = true
		
		if is_straight?
			if is_flush?
				@type = :straight_flush
			else
				@type = :straight
			end
			
			mark_all_used!
		elsif is_of_a_kind?(4)
			val = val_of_a_kind(4)
			@type = :four_of_a_kind
			mark_all_vals_used!(val)
		elsif is_flush?
			@type = :flush
			mark_all_used!
		elsif is_full_house?
			@type = :full_house
			mark_all_used!
		elsif is_of_a_kind?(3)
			val = val_of_a_kind(3)
			@type = :three_of_a_kind
			mark_all_vals_used!(val)
		elsif is_two_pair?
			@type = :two_pair
			val = val_of_a_kind(2)
			mark_all_vals_used!(val)
			val = val_of_a_kind(2)
			mark_all_vals_used!(val)
		elsif is_of_a_kind?(2)
			@type = :pair
			val = val_of_a_kind(2)
			mark_all_vals_used!(val)
		else
			@type = :singleton
		end
	end
	
	def print_hand
		hand_str = ""
		
		cards.each{|card| hand_str += (card.to_s + " ")}
		puts hand_str
		puts "Type: " + @type.to_s + " Ranking val: " + $hand_rankings[@type].to_s
		puts "Highest Card: " + high_used_val?.to_s
		puts "Highest Unused: " + high_unused_val?.to_s
	end
	
	def ranking_val?
		return $hand_rankings[@type] 
	end

	def >(hand)
		return ((self <=> hand) == 1)
	end
	
	def <(hand)
		return ((self <=> hand) == -1)
	end
	
	def ==(hand)
		return ((self <=> hand) == 0)
	end

	def <=>(hand)
		hand.determine_hand_value! if !hand.hand_val_determined
		self.determine_hand_value! if !@hand_val_determined
		
		if self.ranking_val? > hand.ranking_val?
			return 1
		elsif self.ranking_val? < hand.ranking_val?
			return -1
		else 
			val = higher_cards?(self.used_cards?, hand.used_cards?)
			if val == 0
				val = higher_cards?(self.unused_cards?, hand.unused_cards?)
			end	
			
			return val
		end
		
		return 0
	end
end

class Card
	attr_accessor :value, :suit, :used
	
	def initialize(str)
		#puts "Card init: " + str.to_s
		value_str = str[0]
		@value = interpret_value(value_str)
		@suit = str[1]
		@used = false
		
		#puts self.to_s
	end
	
	def interpret_value(str)
		return str.to_i if str.to_i != 0
		return 10 if str == "T"
		return 11 if str == "J"
		return 12 if str == "Q"
		return 13 if str == "K"
		return 14 if str == "A" && $aces_high
		return 1 if str == "A" && !$aces_high
		
		return -1
	end
	
	def to_s
		return value.to_s + " " + suit
	end
end

File.open(ARGV[0]).each_line do |line|
	line.strip!
	
	left = Hand.new(line[0..13])
	right = Hand.new(line[15..28])
	
	cmp = left<=>(right)
	#puts line
	#left.print_hand
	#right.print_hand
	if cmp == 0 
		puts "none"
	elsif cmp == 1
		puts "left"
	else
		puts "right"
	end
end