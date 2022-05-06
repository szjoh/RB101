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

def hands(hand)
  hand.map { |card| card[0] }
end

def hand_value(hand)
  hands = hand.map { |card| card[1] }
  total = hands.sum
  (total -= 10) if total > 21 && hands.include?(11)
  total
end

def display_hand(hand)
  hands(hand).join(" & ")
end
# -------- methods for instructions------------

def objective
  <<~EXPLAIN
    =======================================================================
                                    OBJECTIVE
    =======================================================================
    To win the game, one must obtain or get closest to 21 without going over.
    If you go over 21, you will automatically lose, known as a "Bust."
    Both you and the dealer will start with two cards.
    As the Player, you will get the first turn.
    You can 'Hit' to add another card to get the value closer to 21 or
    'Stay' to maintain the hand you have.
    Once you 'Stay,' it will be the dealer's turn.
    The dealer will also hit or stay depending on their hand.
    Dealer MUST hit if their hand is under 17, and stay if greater than 17.

    => Press any key to continue...
    EXPLAIN
end

def card_value_instructions
  <<~EXPLAIN
    =======================================================================
                                   CARD VALUES
    =======================================================================
    NUMBER CARDS are their number's value. Number cards include 1-10.
    e.g. 4 of Hearts card's value is 4. \n\n
    FACE CARDS have the value of 10. Face cards include Jack, Queen and King.
    e.g. Jack of Spades card's value is 10 \n\n
    ACE CARDS can have the value of 11 or 1.
    e.g. Ace of Diamonds and Queen of Clubs will have the total value of 21.
    e.g. Ace of Diamonds and Ace of Spades will have the total value of 12.
      If a hand with an Ace exceeds 21, then the Ace card will take the value of 1. \n\n
    => Press any key to start the game!
  EXPLAIN
end
# ------- end method for instructions----------------

def instructions
  prompt "Would you like a tutorial on how to play 21?"
  prompt "press any key for tutorial or type 'n' for no"
  instruct = gets.chomp
  system 'clear'
  loop do
    break if instruct.start_with?('n')
    puts objective
    continue = gets.chomp
    break if continue
  end
  system 'clear'
    loop do
      break if instruct.start_with?('n')
      puts card_value_instructions
      continue = gets.chomp
      break if continue
    end
  system 'clear'
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

def pick_cards(hand, deck)
  hit(hand, deck)
  remove_hands_from_deck(hand, deck)
end

def dealer_turn(hand, deck)
  loop do
    case hand_value(hand)
    when (17..21)
      prompt "Dealer will stay"
    when (0..16)
      puts "Dealer will hit."
      pick_cards(hand, deck)
    end
    break if hand_value(hand) >= 17
  end
end

# Some logic for game_eval method -------------------------------------------
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
# End of game_eval logics --------------------------------------------------

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

def game_summary(player, dealer)
  puts "============================================================"
  game_eval(player, dealer)
  display = <<~DISP
    You have played #{display_hand(player)}
    for a total of #{hand_value(player)} \n
    Dealer played #{display_hand(dealer)}
    for a total of #{hand_value(dealer)}
    ============================================================
    DISP
  puts display
end

def hit_sequence(player, deck)
  hit(player, deck)
  remove_hands_from_deck(player, deck)
  summary_of_hand(player)
end

def invalid_hit_stay_response
  message = <<~MSG
    That is an invalid input
    Type 'h' or 'hit' to Hit
    's' or 'stay' to Stay.
  MSG
  puts message
end

def prompt_player_twenty_one
  puts "======================================"
  prompt "CONGRATS! You hit 21. You must stay."
  puts "======================================"
end

# ------- END OF METHODS ----------

player_win = []
dealer_win = []
loop_counter = 0
loop do
  deck = initialize_deck
  player_cards = []
  dealer_cards = []
  2.times do
    pick_cards(player_cards, deck)
    pick_cards(dealer_cards, deck)
  end

  system 'clear'
  if loop_counter < 1
    prompt "Welcome to 21!\n\n"
    instructions
  end
  prompt "Your cards:"
  prompt "#{display_hand(player_cards)}\n\n"
  prompt "Dealer's cards:"
  prompt "#{hands(dealer_cards)[0]} & unknown card\n\n"

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
      hit_sequence(player_cards, deck)
      break if hand_value(player_cards) > 21
    elsif input.start_with?('s')
      dealer_turn(dealer_cards, deck)
      break
    else
      invalid_hit_stay_response
    end
  end

  puts game_summary(player_cards, dealer_cards)

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
  loop_counter += 1
  end_response = gets.chomp
  prompt "Thanks for playing 21!" if end_response.start_with?("n")
  break if end_response.start_with?("n")
end