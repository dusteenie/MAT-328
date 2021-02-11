# @author Sarah Stepak
# @since  02.11.2021
# @program Lab 5 Notes
# @dataset dogs, dates
# Data provided by Dr. S. Hardy.



# list()
# An array, not constrained by type.
# SYNTAX
# Create a list with list()
# Delete a list with unlist()
# 
# Example
list_data &lt;- list(c('Red','Green','Blue'),c(21,52,11,77), TRUE)
list_data
unlist(list_data)

help(list)
help(unlist)



# More functions for Data Cleaning
# 
# returns the number of characters in a string
# nchar(value) 
#
# return a list of the unique values
# unique(vector)
#
# returns the number of elements in the vector
# length(vector) 
#
# sort(vector)
#
#
# Example
length(unique(vector))
sort(unique(vector))



# String Functions
#
# extracts portion of character value/string
# substring(value, start=n1, stop=n2) 
# 
# substitutes all instances of pattern1 with pattern2.
# gsub( pattern1, pattern2, variable)



# Paste functions
# There are two forms
#
# creates one character vector from two input vectors
# SYNTAX:
# paste(x, y, sep = '')
#
# #creates a single value by joining all the elements of one vector
# paste(x, collapse = '')
help(paste)


# Toupper() and Tolower() functions
# converts case of character variables and is
#  useful for data that is in more than one format
#
# Hypothetical situation:
month #returns an 'ugly' list
# Only allows a format of up to 3 chars
month.new <- substring(month,1,3) 
# capitalizes everything
month.new <- toupper(month.new) 
# Only capitalizes the first letter (out of the three) and keeps the rest lowercase.
month.fancy <- paste(toupper(substring(month,1,1)),tolower(substring(month,2,3)),sep='')



# strsplit() function
# splits a string at occurrences of the split character
#
# SYNTAX
# strsplit(x,split) 
#
#
# Prints all the birthdays
dogs$birthdate
# Creates a list called 'temp' where it 'splits' the birthday by '/'
# Returns: [[1]] [1] '10' '6' '2018'
temp <- strsplit(dogs$birthdate,'/')
# Next, we unlisted temp to create one big vector of all the elements
# output is in: month day year pattern
unlist.temp <- unlist(temp)
# The following prints out only the month
dogs$birth.month <- unlist.temp[seq[1,60,3]]
# The following prints out only the month
dogs$birth.day <- unlist.temp[seq[2,60,3]]



# Finding year using nchar
nchar(dogs$birthdate)
# the year is the last four chars, so
substring(dogs$birthdate, nchar((6,7,8,9)- 3),nchar(dogs$birthdate))

