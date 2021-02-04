# @author Sarah Stepak
# @since  02.03.2021
# @program Lab 2
# Data provided by Dr. S. Hardy.

#Assignment Operators
# x = 4  #not preffered
# 4 = x  #invalid syntax
x <- 4
4 -> x

is.numeric(x) #checks to see if the var is a number
is.integer(x) #boolean, checks to see if var is an int


#Vectors
#Can only take elements of the same data type
# c in c(...) means concatination 

vector1 <- c("a","b","c")
vector2 <- c(1,3,5,7)
vector3 <- c(vector1, vector2)
#RESULT: [1] "a" "b" "c" "1" "3" "5" "7"
#        vector 2 has been casted to type char


#Data Frames
# A set of vectors of equal length
# tibbles are modernized dataframes
is.data.frame(lowbirthwt) #returns true

# Notation to parse thru a specific part of the dataframe
# dataset$var
# OR
# dataset[row,col]

#Examples
lowbirthwt$AGE
lowbirthwt[2,3]
lowbirthwt[2:5, 3:4]