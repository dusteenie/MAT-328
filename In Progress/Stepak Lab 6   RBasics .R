# @author Sarah Stepak
# @since  02.18.2021
# @program Lab 6 
# @dataset IFW_Kills and maine_pop_by_city
# Data provided by Dr. S. Hardy.

# Imports the datasets
ifw <- IFW_Kills_test
citypop <- maine_pop_by_city

# Checks the dimension and the names for each data set.
dim(ifw)
names(ifw)
#
dim(citypop)
names(citypop)

# Identifies matching column names using intersect()
intersect(names(ifw),names(citypop))

# Finds all unique values for each city col in each subset
# unique(c(ifw$city,citypop$city))
unique(ifw$city)
unique(citypop$city)

# Sorts the unique city values in the ifw data
sort(unique(ifw$city))[1:50] 


#table(sort(ifw$city, decreasing = FALSE), exclude = NULL)

# Standardizes the formatting of city in the ifw data set. 
# Then check the length of the vector again.
#
# Why are these NULL ?
temp <- toupper(ifw$city)
temp <- gsub(" ", ".",temp)
temp
length((ifw$city))
length((temp))

# Creates a counter var in ifw
#
# How on earth do we find the number of each species
# harvested in each city, and add that to the counter
ifw$count <- 1


# Finds the sum of count using aggregate()
