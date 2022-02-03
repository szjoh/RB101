require 'date'
#date is a subclass of object that includes Comparable module. 
puts Date.civil 
#civil method will create the date object indicating the given calendar date. 
puts Date.civil(2016)

puts Date.civil(2016,5)

puts Date.civil(2016, 5, 13)