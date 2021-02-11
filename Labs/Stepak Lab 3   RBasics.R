# @author Sarah Stepak
# @since  02.04.2021
# @program Lab 3 (R Basics continued)
# Data provided by RStudio.


# Checking basic information about the data

#Tells you about the data
help(airquality)
#Shows you the dimentions of the data
dim(airquality)
#Shows the names of the cols
names(airquality)
#Shows you a structured summary of the data
str(airquality)
# Lets you see all of the data
view(airquality)
#Shows you a lttle summary of the data
summary(airquality)


# Logical ops and making subsets and tables of specific cols of the data

#Makes a table of cols month and day to visually check the data
table(airquality$month, exclude = NULL)
table(airquality$Day, exclude=NULL)
#
#The following is a logical condition which shows you
# a vector of length Temp, containing T/F if the temperature
# is over 90.
airquality$Temp > 90
#
#The following takes the previous statement, and makes
# a nice table containing the sum of T or F.
table(airquality$Temp > 90, exclude = NULL)
#
#Shows the sum of the logical vector
sum(airquality$Temp > 90)
#
#The following turns the previous original statement into
# a vector only containing 0s and 1s.
as.numeric(airquality$Temp > 90, exclude = NULL)

#The following makes a new table which specifies what 
# we want to see
subset(airquality, Temp>90) #makes a set containing all the information for the days with temp>90
Temp.gt.90 <- subset(airquality, temp>90)
#Can also specify which columns to keep
subset(airquality, Temp > 90, select = c(Ozone, Temp))
subset(airquality, Temp > 90, select = Ozone:Temp)
subset(airquality, Temp > 90, select = -Day)
#
# and/or ops
#
#Now we want to keep all the days where Ozone is greater than 100 AND
# temp > 90.
subset(airquality, Ozone > 100 & Temp >=90)
#Now we want to keep all the days where Ozone is greater than 100 OR
# temp > 90.
subset(airquality, Ozone > 100 | Temp >=90)
#
# == / !=
subset(airquality, Month==6) #equals
subset(airquality, Month!=5) #not equals
#
subset(airquality, Month==6 | Month==7) #equals 6 OR equals 7
subset(airquality, Month!=5 & Month==6:7) #not equals and months 6-7


# NA

# the following returns true if the value is NA, false otherwise
is.na()
airquality$Ozone #has a lot of NAs
is.na(airquality$Ozone) #creates a table of T/F if the value is NA
# NOTE Ozone == "NA" will NOT work
#
#sums the total amount of NAs
sum(is.na(airquality$Ozone)) 
#sums the total amount of NOT NAs
sum(!is.na(airquality$Ozone))
#
#tables the total number of NAs in Ozone per month
table(airquality$Month,is.na(airquality$Ozone))
#
#Will return all the observations where Ozone is NA.
subset(airquality, is.na(Ozone)) 
# Will return all the observations where Ozone is not NA.
subset(airquality, !is.na(Ozone)) 
#THE FOLLOWING WILL NOT WORK
#subset(airquality, Ozone==NA)
#subset(airquality, Ozone!=NA)


# Conditions with Duplicated()

#Makes a table of T/F if a value is duplicated
duplicated(airquality$Month)
#Makes a table of T/F if a value is NOT duplicated
!duplicated(airquality$Month)
#
#Makes a table which shows you the total number of items which were not duplicated
subset(airquality, !duplicated(Month))