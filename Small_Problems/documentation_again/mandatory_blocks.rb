#using the array#bsearch method to search ordered array. Use this method to find values > 8.
a = [1, 4, 8, 11, 15, 19]

#bsearch {|element| ... } -> object 
#returns an element from self selected by a binary search. 

bsearch(a) 
{ |num| 
num > 8
}