# The following program contains code and notes for 
# the second linear models part
# Lab LM2 (Linear Models Part 2) (Note: there is no Lab LM1)
# Note! Excel files lose their extension upon import
#
# @author   Sarah Stepak
# @program  Linear Models 2.R
# @since    03.16.2021
# @dataset Advertising


# Import statement
library(ggplot2)
ad <- advertising #dataset


# Preforms regression analysis using Sales as the response var
# and TV as the explanatory var
#
ad.lm.1 <- lm(sales~TV, data=ad)

# Creates and plots a residual plot as well as the Q-Q plot 
# (i.e. first two diagnostic plots)
#
plot(ad.lm.1, which=c(2,1))

# Plots the regression line with ggplot.
#
ggplot(ad, aes(x=TV, y=sales)) +
  geom_point()+
  geom_smooth(method="lm")



# Preforms regression analysis using Sales as the response var
# and Radio as the explanatory var
#
ad.lm.2 <- lm(radio~sales, data=ad)
plot(ad.lm.2, which=c(2,1))
ggplot(ad, aes(x=sales, y=radio)) +
  geom_point()+
  geom_smooth(method="lm")



# Preforms regression analysis using Sales as the response var
# and Newspaper as the explanatory var.
#
ad.lm.3 <- lm(newspaper~sales, data=ad)
plot(ad.lm.3, which=c(2,1))
ggplot(ad, aes(x=sales, y=newspaper)) +
  geom_point()+
  geom_smooth(method="lm")



# Preforms regression analysis using TV as the response var and 
# Radio as the explanatory variable.
#
ad.lm.4 <- lm(radio~TV, data=ad)
plot(ad.lm.4, which=c(2,1))
ggplot(ad, aes(x=TV, y=radio)) +
  geom_point()+
  geom_smooth(method="lm")




# Preforms regression analysis using TV as the response var and 
# Newspaper as the explanatory variable.
#
ad.lm.5 <- lm(newspaper~TV, data=ad)
plot(ad.lm.5, which=c(2,1))
ggplot(ad, aes(x=TV, y=newspaper)) +
  geom_point()+
  geom_smooth(method="lm")




# RESPONSE QUESTIONS
# -------------------------------------------------------------
# Q. Which predictor variable (i.e. the explanatory variable) is 
#    the best? Explain your reasoning.
# A. Problem 1's predictor/explain variables were the best in my opinion. 
#    They had created a linear graph which I believe best suited the data. 

# Q. What did you learn from 5 and 6 about the relationships 
#    between the predictor variables?
# A. I learned that not all relationships can be visualized linearly.
#    They had no correlation between one another.