# This program contains code as well as responses to Linear Models Lab 6.
# Please note, there is no LM 5
#
# @author   Sarah Stepak
# @program  Stepak LM6.R
# @since    04.23.2021
# @dataset  Credit_version_2.csv


# Import statements
library(ggplot2)
credit <- CreditV2 #imports the dataset


# Fits a model to predict Balance based on Age and Income. Saves
# the model to an object.
credit.lm <- lm(formula = Age~Income+Balance, data = credit)
summary(credit.lm)

range(credit$Income)
range(credit$Balance)
tempgrid <-expand.grid(Income = seq(6.5, 550.0), Balance = seq(0,1999))
tempgrid$predict <- predict(credit.lm, newdata = tempgrid)
# Creates a contour plot of the above graph
ggplot(tempgrid, aes(x=Balance, y=Income, z=predict))+
  geom_contour_filled()


# Fits a full quadratic model
credit.lm2 <- lm(formula = Age~Income+Balance + Income:Balance + 
                   I(Income^2) , data = credit)
summary(credit.lm2)
tempgrid$predict2 <-predict(credit.lm2, newdata = tempgrid)
ggplot(tempgrid, aes(x=Balance, y=Income, z = predict2))+
  geom_contour_filled()