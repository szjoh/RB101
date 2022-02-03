#Write a method that takes one argument, a string, and returns a new string with the words in reverse order. 
#Problem: write a program that will distinguish the individual words between the space. 
#Will will also need to return space as its own thing.
#IF there are no words and only spaces, it will still need to return one space 


def reverse_sentence(sentence)
sentence.split.reverse.join(" ")
end

puts reverse_sentence("Hello World") == "World Hello"
puts reverse_sentence("Reverse these words") == "words these Reverse"
puts reverse_sentence("") == ""
p reverse_sentence("   ") == ""