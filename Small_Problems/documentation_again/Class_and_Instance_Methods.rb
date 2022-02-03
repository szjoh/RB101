#Class vs Instance Methods

class Hello
#This is a class method 
  def self.introduction
    p "Hello there!"
  end

# This is an instance method 
  def goodbye
    p "bye bye!"
  end
end 

#properly written class method called on the class Hello. 
Hello.introduction

#improperly written, will throw an error, as an undefined method of the Hello:Class. 
#Hello.goodbye

#You need to create a new instance of that class to use it. creating a new instance of the Hello Class. , stored as the 
#'salutations' variable. instance method called on the objects. 
salutations = Hello.new 
#salutations is the object of the Hello class. 
salutations.goodbye

# This will throw an error as well, undefined method for Hello 
#salutations.introduction

#whats the purpose of these two? 

#This is bad ruby programming. This creates instance of the class 
#Hello.method_1
#Hello.method_2
#Hello.method_3
#Hello.method_4
#Hello.method_5

#this is better ruby programming -- creating a new instance method,
#salulations.method_1
#salulations.method_2
#salulations.method_3
#salulations.method_4
#salulations.method_5

# THis is because a Class is like a blueprint of the house. you cant do much with the blueprint alone, but it does hold info
# Instance (aka Object) is the actual house that is built based on the blueprint. You can change the wall color, use a 
#   diffent countertop, different tiles, ect. You can independently change the properties of each instance of a class
#   without affecting the other instances. 
