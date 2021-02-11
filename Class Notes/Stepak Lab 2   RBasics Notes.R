# @author Sarah Stepak
# @since  02.03.2021
# @program Lab 2 Notes
# @dataset lowbirthwt, mtcars
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


#Built in Functions
#Notation: function(arg)
# have a question on a function? help(functionName) pulls up documentation
#
# names(dataset)# lists the variable names 
# dim(dataset)  # returns the dimension i.e. rows and columns 
# nrow(dataset) # returns the number of rows in the data set 
# ncol(dataset) # returns the number of columns in the data set 
# View(dataset) # puts a spreadsheet style view of the dataset in a 
                # tab in the script window 
#
# summary(dataset) 
# The following prints data types of the columns, 
# numeric summaries of numeric variables, and counts 
# for factors note that summary will also give numeric 
# summaries for categorical variables coded with numbers
#
# head(dataset) # prints the first five rows to the console 
# tail(dataset]) # prints the last five rows to the console 
# length(vector) # lists the length of a vector 



#The table() functions
# creates tables for one or two character vars
#
# table(var1) # produces a list of counts for a character variable 
# table(var1,var2) # produces a crosstab for two character variables 
# table(var1,var2,exclude=NULL) # by default NA values are excluded, adding exclude=NULL 
                                # will also tabulate the NA values 
#EXAMPLES:
table(mtcars$cyl,exclude=NULL)
table(mtcars$gear,exclude=NULL)
table(mtcars$cyl,mtcars$gear)  
table(mtcars$am,mtcars$gear)


#The prop.table() functions
# takes a crosstab created by the table function and outputs the 
# proportions by row or column
#
# prop.table(table.output, margin= )

#EXAMPLES
tabcylgear <- table(mtcars$cyl,mtcars$gear) 
tabcylgear 
prop.table(tabcylgear, margin=1) 
prop.table(tabcylgear, margin=2) 
round(prop.table(tabcylgear, margin=1),2) 
round(prop.table(tabcylgear, margin=2),2) 


#Numerical Summary Functions
# To find the mean, median, min, max, var and sd of the engine displacement
# Examples:
mean(mycars$disp) 
median(mycars$disp) 
min(mycars$disp) 
max(mycars$disp) 
var(mycars$disp) 
sd(mycars$disp) 

#aggregate() function
# Structure:
#aggregate(numvar ~ catvar, data=dataset, function) 
#aggregate(numvar ~ catvar1 + catvar2, data=dataset, function) 
#
#EXAMPLES
aggregate(mpg~cyl,data=mtcars, median)
aggregate(hp~am,data=mtcars, mean)
aggregate(mpg~am+cyl,data=mtcars, mean)