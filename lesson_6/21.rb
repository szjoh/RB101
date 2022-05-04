SUITS = ["of Hearts", "of Spades", "of Clubs", "of Diamonds"]
VALUES = [["Ace ", 11], ["2 ", 2], ["3 ", 3], ["4 ", 4],
          ["5 ", 5], ["6 ", 6], ["7 ", 7], ["8 ", 8],
          ["9 ", 9], ["10 ", 10], ["Jack ", 10], ["Queen ", 10],
          ["King ", 10]]

def initialize_deck
  deck = (SUITS.map do |suit|
    VALUES.map { |value| [value[0] + suit, value[1]] }
  end)
  deck.flatten(1)
end

def prompt(message)
  puts "=> #{message}"
end

def p_d_hand(hand)
  hand.map { |card| card[0] }
end

def hand_value(hand)
  hands = hand.map { |card| card[1] }
  total = hands.sum
  (total -= 10) if total > 21 && hands.include?(11)
  total
end

def display_hand(hand)
  p_d_hand(hand).join(" & ")
end

def summary_of_hand(hand)
  prompt "Your cards are: #{display_hand(hand)}"
  prompt "for a sum of #{hand_value(hand)}" if hand_value(hand) < 21
end

def hit(hand, deck)
  hand << deck.sample
end

def remove_hands_from_deck(hand, deck)
  hand.each do |cards|
    deck.reject! { |card| card == cards }
  end
end

def stay(hand)
  prompt "Your cards are: #{display_hand(hand)}"
  case hand_value(hand)
  when 0..20
    prompt "for a sum of #{hand_value(hand)}"
  when 21
    prompt "CONGRATS, YOU HAVE 21! You must stay."
  end
end

def dealer_hit_or_stay(hand, deck)
  loop do
    case hand_value(hand)
    when (17..21)
      prompt "Dealer will stay"
    when (0..16)
      puts "Dealer will hit."
      hit(hand, deck)
      remove_hands_from_deck(hand, deck)
    end
    break if hand_value(hand) >= 17
  end
end

def winning_play?(player, dealer)
  hand_value(player) == 21 && hand_value(dealer) != 21 ||
    hand_value(player) < 21 && hand_value(player) > hand_value(dealer)
end

def losing_play?(player, dealer)
  hand_value(player) < hand_value(dealer) ||
    hand_value(dealer) == 21 && hand_value(player) != 21 ||
    hand_value(player) > 21 && hand_value(dealer) < 21
end

def draw?(player, dealer)
  hand_value(player) == hand_value(dealer)
end

def busted?(cards)
  hand_value(cards) > 21
end

def game_eval(player, dealer)
  if busted?(player)
    prompt "YOU BUSTED. Dealer wins."
  elsif busted?(dealer)
    prompt "Dealer BUST. YOU WIN!"
  elsif winning_play?(player, dealer)
    prompt("YOU WIN!")
  elsif draw?(player, dealer)
    prompt "It's a draw!"
  elsif losing_play?(player, dealer)
    prompt("You've lost.")
  end
end

def prompt_player_twenty_one
  puts "======================================"
  prompt "CONGRATS! You hit 21. You must stay."
  puts "======================================"
end

# ------- END OF METHODS ----------

player_win = []
dealer_win = []

loop do
  deck = initialize_deck
  player_cards = []
  dealer_cards = []
  player_cards = deck.sample, deck.sample
  remove_hands_from_deck(player_cards, deck)
  dealer_cards = deck.sample, deck.sample
  remove_hands_from_deck(dealer_cards, deck)
  dealer_total = hand_value(dealer_cards)
  player_total = hand_value(player_cards)

  system 'clear'
  prompt "Welcome to 21!"
  prompt "You will start with two cards: "
  prompt display_hand(player_cards)
  prompt "Dealer also has two cards:"
  prompt "#{p_d_hand(dealer_cards)[0]} & unknown card"

  loop do
    player_total = hand_value(player_cards)

    case player_total
    when (0..20)
      prompt "Would you like to hit or stay?"
      input = gets.chomp.downcase
    when 21
      prompt_player_twenty_one
      input = 's'
    end

    if input.start_with?('h')
      system 'clear'
      hit(player_cards, deck)
      player_total = hand_value(player_cards)
      remove_hands_from_deck(player_cards, deck)
      summary_of_hand(player_cards)
      break if player_total > 21
    elsif input.start_with?('s')
      dealer_hit_or_stay(dealer_cards, deck)
      dealer_total = hand_value(dealer_cards)
      break
    else
      prompt "That is an invalid input"
      prompt "Type 'h' or 'hit' to Hit"
      prompt "'s' or 'stay' to Stay. "
    end
  end

  player_total = hand_value(player_cards)
  dealer_total = hand_value(dealer_cards)

  puts "========================================================="
  game_eval(player_cards, dealer_cards)
  prompt "You have played #{display_hand(player_cards)}"
  prompt "for a total of #{player_total}"
  prompt "Dealer played #{display_hand(dealer_cards)}"
  prompt "for a total of #{dealer_total}"
  puts "========================================================="

  if winning_play?(player_cards, dealer_cards) || busted?(dealer_cards)
    player_win << 1
  elsif losing_play?(player_cards, dealer_cards) || busted?(player_cards)
    dealer_win << 1
  end

  prompt "player: #{player_win.count}, dealer: #{dealer_win.count}"

  if player_win.count == 5
    prompt "Congrats for winning 5 rounds. This is the end of the game."
    break
  elsif dealer_win.count == 5
    prompt "Dealer has won 5 rounds. This is the end of the game."
    break
  end

  prompt "Would you like to go again?"
  end_response = gets.chomp
  break if end_response.start_with?("n")
end