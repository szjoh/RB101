#Write a method that takes one argument, a + interger, nad returns a list of digits in the number. 

#def digit_list(num)
#  num.digits.reverse
#end 

def digit_list(num) 
  num.to_s.chars.map(&:to_i)
end 
puts digit_list(123456) == [1, 2, 3, 4, 5, 6]
puts digit_list(7) == [7]
puts digit_list(375290) == [3, 7, 5, 2, 9, 0]
puts digit_list(444) == [4, 4, 4]