vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck', 'suv'
]
=begin
def count_occurances(veh)
a = 0
new_array = veh.uniq
  loop do
  veh_count = veh.count(new_array[a])
  puts "#{new_array[a]} => #{veh_count}"
  a += 1
  break if a == new_array.count 
  end
end 
count_occurances(vehicles)
=end

#def count_occurances(veh)
#  veh.map!(&:downcase)
#veh.tally {|k,v| puts "#{k} => #{k}"}
#end 
#
#puts count_occurances(vehicles)

def count_occurances (arr)
  occurances = {}

  arr.uniq.each do |element| 
    occurances[element] = array.count(element)
  end
  occurances.each do |element, count|
    puts "#{element} => #{count}"
  end
end


