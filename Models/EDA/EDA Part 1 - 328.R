# The following program contains example code for 
# Exploratory Data Analysis (EDA)
#
# @author   Dr. Sarah Hardy
# @author   Sarah Stepak
# @since    02.23.2021
# @dataset  mpg   Given example dataset from ggplot2


# To install packages, the package name needs to be in double quotes
#install.packages("ggplot2") 
# You only need to install packages once

# Imports ggplot2 package
library(ggplot2) #once per R session


# Investigates the data for any 'unusual' points by adding
# a third variable on the graph. 
# The following should be run by section.
# NOTE: the arrows above the plot window can be used to move 
#       among multiple plots
summary(mgp)
names(mpg)
dim(mpg)
table(mpg$year)
table(mpg$cyl)
table(mpg$drv)
table(mpg$trans)
table(mpg$class)


# The following makes scatter plots of engine size (displ) 
# and highway mileage.
#
# Scatter plot with base R
plot(hwy~displ,data=mpg)
#
# Scatter plot with ggplot2
# Note: you NEED the + sign!
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point()


# Investigates the unusual points in the previous graph
# Shows different vehicle classes with different colors
#
# with base R  
plot(hwy~displ,data=mpg,type="n",xlim=c(min(mpg$displ),max(mpg$displ)),ylim=c(min(mpg$hwy),max(mpg$hwy)))
points(hwy~displ,data=subset(mpg,class=="2seater"),col="blue")
points(hwy~displ,data=subset(mpg,class=="compact"),col="red")
points(hwy~displ,data=subset(mpg,class=="midsize"),col="green")
points(hwy~displ,data=subset(mpg,class=="minivan"),col="pink")     
points(hwy~displ,data=subset(mpg,class=="pickup"),col="purple")
points(hwy~displ,data=subset(mpg,class=="subcompact"),col="orange")
points(hwy~displ,data=subset(mpg,class=="suv"),col="cyan")
#
# with ggplot2
ggplot(mpg,aes(x=displ,y=hwy,color=class)) + geom_point()


# Maps other categorical variables to color
ggplot(mpg,aes(x=displ,y=hwy,color=trans)) +  geom_point()
ggplot(mpg,aes(x=displ,y=hwy,color=drv)) +  geom_point()
ggplot(mpg,aes(x=displ,y=hwy,color=fl)) +  geom_point()


# Using the shape aesthetic - two examples
# NOTE: Shape is better for color blindness, as well as photocopying
#       There are 25 possible shapes, however warning >= 6.
ggplot(mpg,aes(x=displ,y=hwy,shape=drv)) +  geom_point()
ggplot(mpg,aes(x=displ,y=hwy,shape=class)) +  geom_point()
# Question: What happened to the suvs in the second plot?
# A: It did not plot them. GGPlot only has 6 shapes


# Creates three plots
ggplot(mpg,aes(x=displ,y=hwy,color=year)) +  geom_point()
ggplot(mpg,aes(x=displ,y=hwy,color=cyl)) +  geom_point()
ggplot(mpg,aes(x=displ,y=hwy,color=cty)) +  geom_point()
# Question: What is the plot doing when you map a numeric  
#           variable to the aesthetic color?
# Question: Which of these last three plots makes sense 
#           for this dataset and which don't?


# year and cyl are both numeric variables in this dataset, 
# However they are not continuous and have only a limited number
# of values. So we treat them as as numerics.
# Uses as.factor() to force a numeric variable to be a categorical factor.
ggplot(mpg,aes(x=displ,y=hwy,color=as.factor(year))) +  geom_point()
ggplot(mpg,aes(x=displ,y=hwy,color=as.factor(cyl))) +  geom_point()


ggplot(mpg,aes(x=displ,y=hwy,size=class)) +  geom_point()
#Hint: What is different about the plot below that makes the aesthetic size a sensible choice?
ggplot(mpg,aes(x=displ,y=hwy,size=as.factor(cyl))) +
  geom_point()

# Question: What is the warning message that you get with the next plot?
# A: Using size for a discrete var is not advised. 
# Question: Why is mapping the variable class to to the aesthetic size 
#           a bad idea?
# A: 


# Creates a scatter plot between displ and hwy
ggplot(mpg,aes(x=displ,y=hwy,size=cty)) +  geom_point()
ggplot(mpg,aes(x=cty,y=hwy,size=displ)) +  geom_point()

# These two plots both show the same three numeric variables. 
# Question: Which would you pick to show in a presentation and why?
#          (There is no right answer on this one.)
# A: I would use the seconod graph becuase it shows the linear 
#    relationship better.


# Adds a trend line to a scatter plot
# NOTE: Two geoms, each geom are seperated by a +
ggplot(mpg,aes(x=displ,y=hwy)) +  geom_point() +  geom_smooth()


# The following is in proper notation. Makes a plot with 
# two smooths.
ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_point() +
  geom_smooth(color="red")+
  geom_smooth(data=subset(mpg,class !="2seater"),color="blue")
# Question: What is being plotted in this graph?
# A: It shows how the trend of '2 seaters' differ from the others


ggplot(mpg, aes(x = displ, y = hwy, colour = displ < 5)) +
  geom_point()
# Question: What happens if you map an aesthetic to a condition
#           like aes(color = displ < 5)?
# A: Maps the color of the result within the plot to it's
#    associated boolean value.


# Example mapping the same variable to two different aesthetics
# This one is the best for colorblindness! 
ggplot(mpg,aes(x=displ,y=hwy,color=drv,shape=drv)) +
  geom_point()
ggplot(mpg, aes(x = displ, y = hwy, color = hwy, size = displ)) +
  geom_point()
# Question: Can you think of any reason why this can be a good 
#           idea?
# A: I think it's a good idea to look at density related graphs.
# Question: Does it make a difference if the aesthetics are 
#           continuous or discrete?
# A: No.

