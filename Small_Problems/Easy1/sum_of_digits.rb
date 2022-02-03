#Write a method that takes one argument, a positive intergerm and returns the sum of its digits 
#Avoid basic looping constructs. 

def sum(number)
  number.to_s.split('').map(&:to_i).reduce(:+)
end

puts sum(23)
