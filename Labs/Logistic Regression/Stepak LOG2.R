# This program contains code as well as responses to 
# Logistic Regression Lab 2.
#
# @author   Sarah Stepak
# @program  Stepak LOG2.R
# @since    04.24.2021
# @dataset  Default (from ISLR)

# Installs packages
#install.packages("bestglm")

# Import statements
library(ggplot2)
library(bestglm)
library(pROC)
library(ISLR)

# Perform a logistic regression analysis to estimate the probability of 
# default with balance as the predictor variable
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


# Finds the predicted probability of default when the balance is...
b0 <- -0.1065
b1 <- 0.005499

# a. $1750
OR <- exp(b0+(b1*1750))
p <- OR/(1+OR)
p

# b. $2200
OR <- exp(b0+(b1*2200))
p <- OR/(1+OR)
p

# What is the balance for which the probability of default is 0.50?
b2 <- (-(b0) / b1)
b2

# Creates a vector predicting/classifying whether or not someone will 
# default using p=0 .50 as the cutoff.
pred.default <- predict(glmfit, type="response")
head(pred.default)

pred.default01 <- ifelse(pred.default < 0.5,0,1)


# Using the predicted default values and the true default values creates 
# a confusion matrix
confusion <- table(Actual=Default$default, Predicted=pred.default01)
confusion

# Find the correct and misclassification rates
correct.rate <- sum(diag(confusion))/sum(confusion)
correct.rate
misclass.rate <- 1-correct.rate
misclass.rate

# Calculate the sensitivity and the specificity
# specificity = trueneg / actualneg
specificiy <- 9625 / (42+9625)
specificiy
# sensitivity = truepos / actualpos
sensitivity <- 100 / (233+100)
sensitivity

# Graph the ROC curves (in base r)

# Pos. rate
par(pty = "s") #makes the plots square
roc(Default$default, glmfit$fitted.values, plot=TRUE)
# False pos. rate
par(pty = "s") #makes the plots square
roc(Default$default, glmfit$fitted.values, plot=TRUE,
    legacy.axes=TRUE, xlab="False Positive Rate", 
    ylab="True Positive Rate")


# What thresholds would give you sensitivities between 0.60 and 0.65?
roc.out <- roc(Default$default, glmfit$fitted.values, plot=FALSE)
names(roc.out)
roc.out$thresholds[roc.out$sensitivities>0.60 & roc.out$sensitivities<0.65]

# ----------------------------------------------------------------------------
# Try adding student to the model and see how it affects the ROC curve.
#
# States the interpretation of the slope
glmfit <- glm(student~balance, data=Default, family=binomial)
summary(glmfit)

# Graphs the ROC curves (in base r)
# Pos. rate
par(pty = "s") #makes the plots square
roc(Default$student, glmfit$fitted.values, plot=TRUE)
# False pos. rate
par(pty = "s") #makes the plots square
roc(Default$student, glmfit$fitted.values, plot=TRUE,
    legacy.axes=TRUE, xlab="False Positive Rate", 
    ylab="True Positive Rate")
