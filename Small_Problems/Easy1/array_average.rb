#Write a method that takes one argument, an array containing intergers, and returns the average of all numbers in the array. 
#The array will never be empty and the numbers will always be positive intergers. Your result should also be an interger. 

=begin
def average(array)
  new_arr = 0
  a = array.count
  number = loop do
    new_arr += array[a-1]
    a -= 1
    break if a == 0
  end
  new_arr/array.count.to_i
end
=end

#=begin
def average(numbers) #create a method
  sum = numbers.reduce(:+) #Using the Enumerable#reduce(also known as #inject)
  sum / numbers.count.to_i #using the math equation of averages 
end
#=end

puts average([1, 6]) == 3 
puts average([1, 5, 87, 45, 8, 8]) == 25
puts average([9, 47, 23, 95, 16, 52]) == 40