# This program contains code as well as responses to Linear Models Lab 8.
#
# @author   Sarah Stepak
# @program  Stepak LM8.R
# @since    04.22.2021
# @dataset  simset1.csv


# Import statements
#install.packages("leaps")
library(leaps)
library(ggplot2)
sim <- simset1 #dataset import

# Makes a scatterplot matrix using the pairs() function
pairs(sim)

# Finds the corr matrix
round(cor(sim,use="pairwise.complete.obs"),2) # Standard

# Finds the best model by preforming backwards elimination sidestep
# Uses .05 as cutoff.
lm.sim <- lm(y~x3+x4+x5, data=sim)
summary(lm.sim)

# Finds the best model by the adjucted R^2 criterion
agregsubsets <- regsubsets(y~x1+x2+x3+x4+x5+x6+x7, data=sim, method="exhaustive")
sumagsubsets <- summary(agregsubsets)
cbind(sumagsubsets$which, sumagsubsets$adjr2)
p1 <- plot(agregsubsets, scale="adjr2")
p1

# Finds the best model by using the Mallows Cp criterion
cbind(sumagsubsets$which, sumagsubsets$cp)
p2 <- plot(agregsubsets, scale="Cp")
p2

# Draw on all subsets variable selection plot (do for both adjR and Cp)


# Divides simset1 into a training and testing dataset
set.seed(717)
#randomly select half the rows for train
train.rows <-sample(1:100,50)
train <- simset1[train.rows,]
#put other rows in test
test <- simset1[-train.rows,]

#fit model with the train set
#lmfit <- lm(y~x3+x4+x5, data=sim) #185985853
#lmfit <- lm(y~x1+x2+x3+x4+x5+x6, data=sim) #214442092
lmfit <- lm(y~x1+x2+x3+x5+x6+x7, data=sim) #112532285


#use the model to predict for the test dataset
predtest <-predict(lmfit,newdata=test)

#find the squared prediction error
prederr <- sum(test$y - predtest)^2
prederr
