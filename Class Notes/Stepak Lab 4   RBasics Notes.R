# @author Sarah Stepak
# @since  02.09.2021
# @program Lab 4 Notes
# @dataset testdata_example_for_class
# Data provided by Dr. S. Hardy.

# Renames the dataset
td <- testdata_example_for_class

#Start with a summary to help reveal data anomalies
summary(td)

# Creating/replacing variables with ifelse() statement
#
# SYNTAX
# new.variable <- ifelse( condition, value1, value2)
# # value1 condition is TRUE
# # value2 condition is FALSE
#
# NOTES:
# This works well when the newly created variable takes on only two values.
# For example, create a Yes/No variable from a 0/1 variable.
#
table(td$dessert,exclude=NULL)
td$dessert.yn <- ifelse(td$dessert==0,"No","Yes")
table(td$dessert,td$dessert.yn, exclude=NULL)
# or
td$dessert.yn <- ifelse(td$dessert==1,"Yes","No")
#
#
#Another example with NA’s in the data
table(td$ex30,exclude=NULL)
#
# NOTE:
# We can use is.na() as a condition
#
# EXAMPLE 
# If the following is true, then the NA var gets placed under
# a col labled "missing." Otherwise it'll print the 
# exercise col.
td$ex30.yn <- ifelse(is.na(td$ex30),"Missing",td$ex30)
table(td$ex30,td$ex30.yn,exclude=NULL)
#
#
# NOTE:
# 99, 999, and 9999 values often used for missing data
# We will replace that data with NA, and use 'temp'
# as a safety precaution so the original doesn't get overwritten.
hist(td$calories)
temp <- ifelse(td$calories==9999, NA, td$calories); temp
td$calories <- temp
rm(temp)
td$calories <- ifelse(td$calories==9999, NA, td$calories)I


# Recoding variables using within() function
# SYNTAX
# dataset <- within(dataset,{
#           new.varname <- NA #must start by creating the
#           new variable
#           new.varname [condition 1] <- “value1”
#           new.varname [condition 1] <- “value2”
#           etc.
#            })
#
# Essentially says we want to work within td. When we are done
# We will put the revied davaset into td.
#
# EXAMPLE
td <- within(td,{})
#
# Another Example
# creating a more descriptive character variable from td$side
table(td$side,exclude=NULL) # Seeing initial data
# initial revision
td <- within(td,{
  side.name <- NA
  side.name [side=="a"] <- "Apple"
  side.name [side=="b"] <- "Banana"
  side.name [side=="g"] <- "Grapes"
  side.name [side=="c"] <- "Carrots"
})
# quick check
table(td$side,td$side.name,exclude=NULL)
# revision
td <- within(td,{
  side.name <- NA
  side.name [side=="a"] <- "Apple"
  side.name [side=="ba"] <- "Banana"
  side.name [side=="g"] <- "Grapes"
  side.name [side=="c"] <- "Carrots"
  side.name [side=="br"] <- "Broccoli"
  side.name [side=="rb"] <- "Broccoli"
})
# quick check
table(td$side,td$side.name,exclude=NULL)


# Another Example
#
table(td$meal) # Seeing inital data
# initial tweak
td <- within(td,{
  meal.cat <- NA
  meal.cat[meal==1] <- "Breakfast"
  meal.cat[meal==2] <- "Lunch"
  meal.cat[meal==3] <- "Dinner"
})
# check
table(td$meal,td$meal.cat,exclude=NULL)
# Data is not on the diagnol because it's alphabetical
#
# NOTE
# Can also use within() to recoding a numeric variable to a categorical variable. Also
# called “data binning.”
# Creates a table for values based on range(s)
td <- within(td,{
  diet.cal <- NA
  diet.cal [calories <= 1500] <- "Lose"
  diet.cal [calories > 1500 & calories <= 2500] <- "Maintain"
  diet.cal [calories > 2500] <- "Gain"
})
table(td$diet.cal,exclude=NULL)
#
# NOTE
# The following makes a HUGE table
# table(td$calories,td$diet.cal)
#Putting a numeric variable in a table statement could create
# a big table. It’s only okay here because it is such a small 
# dataset that there are a limited number of unique values for
# td$calories


# Ordering categories with an ordered() statement
# SYNTAX:
# dataset$variable <- ordered(dataset$variable,levels=c( list of levels ))
#
# Reorders the table from Breakfast, Dinner, Lunch to
# Breakfast, Lunch, Dinner
table(td$meal.cat,exclude=NULL)
td$meal.cat <- ordered(td$meal.cat,levels=c("Breakfast","Lunch","Dinner"))
table(td$meal.cat)
# Reorders the table from Gain, Lose, Maintain to
# Lose Maintain Gain
table(td$diet.cal,exclude=NULL)
td$diet.cal <- ordered(td$diet.cal,levels=c("Lose","Maintain","Gain"))
table(td$diet.cal)


# Substring a character variable
# SYNTAX
# substring(character.variable, first, last)
#
# EXAMPLES
date.var
#create another variable with just the month
month <- substring(date.var,6,7); month
#create another variable with just the day of month
day.of.month <- substring(date.var,10,11); day.of.month