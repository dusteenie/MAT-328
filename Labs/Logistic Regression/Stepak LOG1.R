# This program contains code as well as responses to 
# Logistic Regression Lab 1.
#
# @author   Sarah Stepak
# @program  Stepak LOG1.R
# @since    04.24.2021
# @dataset  Default (from package ISLR)

# Installs packages
# install.packages("ISLR")

# Import statements
library(ISLR)
library(ggplot2)
library(MASS)


# Estimates the probability of default with balance as the predictor variable.
# -----------------------------------------------------------------------------

# Makes an appropriate box plot
ggplot(Default, aes(y=as.factor(default), x=balance, fill=as.factor(default))) +
  geom_boxplot() +
  labs(title="Default with Balance as the predictor")

# States the interpretation of the slope
glmfit <- glm(default~balance, data=Default, family=binomial)
summary(glmfit)

# Graphs the predicted probability curve
ggplot(Default, aes(x=balance, y=(as.numeric(default))-1)) + 
  geom_point() +
  stat_smooth(method="glm", 
              method.args=list(family=binomial),
              se=FALSE)+
  geom_hline(yintercept=0.5, color="red")+
  labs(title="Predicted Probability Curve",
       x="Balance", y="Default")





# Estimates the probability of default with income as the predictor variable.
# -----------------------------------------------------------------------------

# Makes an appropriate box plot
ggplot(Default, aes(y=as.factor(default), x=income, fill=as.factor(default))) +
  geom_boxplot() +
  labs(title="Default with Income as the predictor")

# Graphs the predicted probability curve
ggplot(Default, aes(x=income, y=(as.numeric(default))-1)) + 
  geom_point() +
  stat_smooth(method="glm", 
              method.args=list(family=binomial),
              se=FALSE)+
  geom_hline(yintercept=0.5, color="red")+
  labs(title="Predicted Probability Curve",
       x="Income", y="Default")

# States the interpretation of exp(b1)
glmfit <- glm(default~income, data=Default, family=binomial)
summary(glmfit)