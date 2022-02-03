=begin
Write a method that takes a string that contains one or more words, and return the string with words that are greater than 
5 characters reversed. 
=end

def reverse_words(sentence)
  array = sentence.split()
  transformed_array = array.each do |word|
  word.reverse! if word.length >= 5
  end
  transformed_array.join(' ')
end

puts reverse_words('Professional')
puts reverse_words('Walk around the block')
puts reverse_words('Launch School')

