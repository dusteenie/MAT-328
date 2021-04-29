# This program contains code as well as responses to 
# Logistic Regression Lab 3.
#
# @author   Dr. Sarah Hardy
# @author   Sarah Stepak
# @program  Stepak LOG3.R
# @since    04.28.2021
# @dataset  Diabetes.csv

# Installs packages
#install.packages("ggpubr")

# Import statements
library(ggplot2)
library(bestglm)
library(caret)
library(pdp)
library(MASS)
library(ggpubr)
library(pROC)
d <- diabetes #dataset import

# Looks at the dim and structure of the data
dim(d)
summary(d)
names(d)
head(d)

# Removes the X1 col
#
#temp <- d[-c(1)]
#View(temp)
#d<-temp
#rm(temp)

# Runs the snippet - Written by Dr. Sarah Hardy
d$weight.yn <- ifelse(d$weight=="?","No","Yes")
d <- subset(d,select=-c(weight,readmitted))

# Creates vector of the names of the categorical and numeric variables.
paste(names(d),collapse = "','")
catgroup <- c('race','discharge','source','max_glu_serum','metformin','insulin',
              'change','diabetesMed','readmitted','admit_type','gender','age')

numgroup <- c('time_in_hospital','num_lab_procedures','num_procedures',
              'num_medications','number_outpatient','number_emergency',
              'number_inpatient','number_diagnoses','readmit01')
  
# Makes a table and aggregates readmit01 by the variable levels using
# a for loop with categorical variables.
d <- as.data.frame(d)
for(i in catgroup){
  tab <- table(d[,i])
  print(as.data.frame(tab))
  ag <- aggregate(readmit01~.,data=d[,c("readmit01",i)], FUN=mean)
  ag <- ag[order(ag$readmit01),]
  print(ag)
  print("----------------")
}

# Collapses age in sensible way (use the aggregated data to guide you)
d <- within(d,{
  agecat <- NA
  agecat [age == "[0-10)" | age == "[10-20)"] <- "1"
  agecat [age == "[20-30)"] <- "2"
  agecat [age == "[30-40)"] <- "3"
  agecat [age == "[40-50)"] <- "4"
  agecat [age == "[50-60)"] <- "5"
  agecat [age == "[60-70)"] <- "6"
  agecat [age == "[70-80)"] <- "7"
  agecat [age == "[80-90)"] <- "8"
})
with(d,table(age,agecat))

# Runs the snippet - Written by Dr. Sarah Hardy
for (i in numgroup) {
  plot <- ggplot(d, aes(x=as.factor(readmit01), y = d[, i])) +
    geom_boxplot() +
    labs(x = i) 
  print(plot)
}

# Creates histograms using the numeric variables in a for loop
for (i in numgroup){
  plot <- ggplot(d, aes(x=d[,i]))+
    geom_histogram()+
    labs(x=1)
  print(plot)
}


# Sets the seed
set.seed(1)

# Partitions the data into train and test subsets using the createDataPartition
partition <- createDataPartition(y=d$readmit01, p=0.75, list=FALSE)
train <- d[partition,]
test <- d[-partition,]
mean(train$readmit01) # checks for similar proportions
mean(test$readmit01) # checks for similar proportions


# Fits a logistic model using the train subset
glm.train <- glm(readmit01 ~ time_in_hospital + num_lab_procedures + num_procedures +
                 num_medications + number_outpatient + number_emergency +
                 number_inpatient + number_diagnoses + race + discharge +
                 source + max_glu_serum + metformin + insulin + change + diabetesMed +
                 admit_type + gender + age, data = train, family = binomial)

# Use stepAIC to reduce the model with the AIC criterion
out.AIC <- stepAIC(glm.train,trace=-1)
out.AIC

# Use stepAIC to reduce the model with the BIC criterion
out.BIC <- stepAIC(glm.train,trace=-1, k = log(nrow(train)))
out.BIC




# Creates ROC curves using the two models
#
# AIC criterion
par(pty = "s") #makes the plots square
pred.aic <- predict(out.AIC, newdata=test, type="response")
pred.bic <- predict(out.BIC, newdata=test, type="response")

roc(test$readmit01, pred.aic, plot=TRUE, legacy.axes=TRUE,
    xlab="False Positive Rate", ylab="True Postive Rate",
    col="red",lwd=3, print.auc=TRUE, main="AIC")

roc(test$readmit01, pred.bic, plot=TRUE, legacy.axes=TRUE,
    xlab="False Positive Rate", ylab="True Postive Rate",
    col="blue",lwd=3, print.auc=TRUE, main="BIC")

# Using the following thresholds to create confusion matrices for both models
# 0.25
pred.aic01 <- ifelse(pred.aic < 0.25,0,1)
confusion.aic <- table(Actual=test$readmit01, Predicted=pred.aic01)
confusion.aic
correct.rate <- sum(diag(confusion.aic)) / sum(confusion.aic)
correct.rate
#0.75
pred.aic02 <- ifelse(pred.aic < 0.75,0,1)
confusion.aic <- table(Actual=test$readmit01, Predicted=pred.aic02)
confusion.aic
correct.rate <- sum(diag(confusion.aic)) / sum(confusion.aic)
correct.rate
# 0.25
pred.bic03 <- ifelse(pred.aic < 0.25,0,1)
confusion.bic <- table(Actual=test$readmit01, Predicted=pred.aic03)
confusion.bic
correct.rate <- sum(diag(confusion.bic)) / sum(confusion.bic)
correct.rate
#0.75
pred.bic04 <- ifelse(pred.aic < 0.75,0,1)
confusion.bic <- table(Actual=test$readmit01, Predicted=pred.bic04)
confusion.bic
correct.rate <- sum(diag(confusion.bic)) / sum(confusion.bic)
correct.rate
