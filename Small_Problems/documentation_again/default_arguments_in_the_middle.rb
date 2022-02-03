#creates a method with 4 arguments. 
#b and c has a default value. 
def my_method(a ,b = 2, c = 3, d)
  p [a, b, c, d]
end

#calling the method created with three arguments. since it has three default values already, it will print 
#4,5,3,6
my_method(4,5,6)
