=begin 
write a method that takes one argumetnt, a positive interger, and returns a string of alternating 1s and 0s
always starting with 1. The length of the string should match the given interger.
=end
=begin
def stringy(number)
  number.even? ? ('10'*(number/2)) : ('10'*(number/2) + '1')
end

puts stringy(6)
puts stringy(9)
puts stringy(4)
puts stringy(7)
puts stringy(0)
=end

# Launch School answer looks rather different. So another solution where you set these values into an array then join. 

def string_lengths(sentence)
  strings = sentence.split
  lengths = []
  counter = 1

  until counter == strings.size do
    word_length = strings[counter - 1].length
    lengths.push(word_length)
    counter += 1
  end

  lengths
end

p string_lengths('To be or not to be')
