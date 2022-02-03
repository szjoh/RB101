#Write method that takes one interger argument (-, +, 0)
#if method True, bumber's absolute value is odd. Assume argument is a valid interger value. 

def is_odd?(number)
  number % 2 == 1
end

puts is_odd?(3)
puts is_odd?(2)
puts is_odd?(-17)
puts is_odd?(4)