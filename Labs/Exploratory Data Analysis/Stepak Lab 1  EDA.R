# The following program contains code for Lab 1 in
# Exploratory Data Analysis (EDA)
#
# @author   Sarah Stepak
# @program  Lab 1 EDA
# @since    02.23.2021
# @dataset  mtcars  Given example dataset from ggplot2


# Imports ggplot2 package
library(ggplot2) #once per R session

# Investigates the data for any 'unusual' points
summary(mtcars)
names(mtcars)
dim(mtcars)
table(mtcars$mpg)
table(mtcars$cyl)
table(mtcars$disp)
table(mtcars$hp)
table(mtcars$drat)
table(mtcars$wt)
table(mtcars$qsec)
table(mtcars$vs)
table(mtcars$am)
table(mtcars$gear)
table(mtcars$carb)


# Uses the color aesthetic with a categorical character 
# variable or a discrete numeric variable using as.factor().
ggplot(mtcars,aes(x=mpg,y=disp,color=as.factor(cyl))) +  geom_point()

# Uses the shape aesthetic different from the vars used in 1.
ggplot(mtcars,aes(x=qsec,y=hp,shape=as.factor(gear))) +  geom_point()

# Uses the size aesthetic different from the vars used in 1 and 2.
ggplot(mtcars,aes(x=drat,y=carb,size=wt)) +  geom_point()

# Maps the same variable in 1 to two different aesthetics
ggplot(mtcars,aes(x=mpg,y=disp,color=cyl,shape=as.factor(cyl))) +
  geom_point()

# Uses the color aesthetic with a numeric variable.
ggplot(mtcars, aes(x = mpg, y = disp, colour = mpg)) +
  geom_point()
ggplot(mtcars, aes(x = mpg, y = disp, colour = cyl)) +
  geom_point()

# Maps a condition to an aesthetic instead of a variable.
ggplot(mtcars, aes(x = mpg, y = disp, colour = gear < 4)) +
  geom_point()

# Uses the geom_smooth geometry.
ggplot(mtcars,aes(x=mpg,y=disp,color=as.factor(cyl))) +  geom_point() +  geom_smooth()