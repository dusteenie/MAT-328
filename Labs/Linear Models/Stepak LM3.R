# This program contains code as well as responses to Linear Models
# Lab 3.
#
# @author   Sarah Stepak
# @program  Stepak LM3.R
# @since    03.18.2021
# @dataset Advertising (TV is explanatory, sales is response)


# Import statements
library(ggplot2)
ad <- advertising #imports the dataset


# Finds the residual standard error using the residuals and 
# confirms that it matches the Residual standard error on the
# output.
#
# Computer Generated Residual Error
ad.lm <- lm(sales~TV, data=ad)
summary(ad.lm)
# Found
sum(ad.lm$residuals^2) # Sum of squared residuals
sum(ad.lm$residuals^2)/23 # MSE (Estimate of the Variation)
sqrt(sum(ad.lm$residuals^2)/23) # Residual Standard error


# Finds and plots the confidence in prediction intervals.
ci.fit <- predict(ad.lm,interval="confidence")
pi.fit <- predict(ad.lm,interval="prediction")
ad$ci.lwr <- ci.fit[,2]
ad$ci.upr <- ci.fit[,3]
ad$pi.lwr <- pi.fit[,2]
ad$pi.upr <- pi.fit[,3]

ggplot(ad,aes(x=TV,y=sales))+
  geom_point()+
  geom_smooth(method="lm")+
  geom_vline(xintercept=7.032594,color="red")+
  geom_hline(yintercept=0.047537,color="red")+
  geom_smooth(aes(y=ci.lwr),color="cyan",se=FALSE)+
  geom_smooth(aes(y=ci.upr),color="cyan",se=FALSE)+
  geom_smooth(aes(y=pi.lwr),color="purple",se=FALSE)+
  geom_smooth(aes(y=pi.upr),color="purple",se=FALSE) 


# RESPONSE QUESTIONS
# -------------------------------------------------------------
# Q. If you want an estimate of sales in a month where you spend
#    $200,000 which interval would you use?
# A. I would use the confidence interval

# Q. If you want an estimate of mean sales per month in a year where
#    you spend $200,000 per month which interval would you use?
# A. I would use the prediction intervals

# Q. Explain interpretation of the R-squared.
# A. R Squared is how well the graph approximates the data.
#    Results are given in  decimals such that we may reflect them
#    As a percentage of sales's variation due to tv. 

# Q. Explains the interpretation of the regression coefficients.
# A. Describes the relationship between sales and tv. In this case
#    they have a positive linear relationship.