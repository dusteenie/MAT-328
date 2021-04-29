# This program contains code as well as responses to Linear Models
# Lab 4.
#
# @author   Sarah Stepak
# @program  Stepak LM4.R
# @since    04.08.2021
# @dataset  Credit version 2.csv


# Import statements
library(ggplot2)
library(GGally)
credit <- CreditV2 #imports the dataset


#1. Use Income as the response and Age as the explanatory look construct a 
#   linear models and look for outliers and influential points.
#
credit.lm <- lm(Income~Age, data=credit)
plot(credit.lm, which=c(5))


#2. Construct a correlation matrix of all the numeric variables rounded 
#   to two decimal places. (removes col's 6-10)
#
# round(cor(credit[,-c(6:10)]),2) # Basic, Used if we do not have any NAs
 round(cor(credit[,-c(6:10)],use="pairwise.complete.obs"),2) # Standard

 
#3. Graph the correlation matrix from the previous question.
#
credit.cor <- round(cor(credit[,-c(6:10)],use="pairwise.complete.obs"),2)
ggcorr(credit.cor)


#4. Repeat 3 after ordering the rows and columns and columns.
#
names(credit) #Prints col names
ord <- order(credit.cor[1,], decreasing = TRUE) # Orders the first row
ord # View the order
temp <- credit.cor[ord,ord] # Saves order to temp
temp #debug
ggcorr(temp)
rm(temp)


#5. Use ggpairs() with just the numeric variables.
ggpairs(subset(credit, select=c(Income, Rating, Limit, Cards, Age, 
                                Education, Balance)))


#6. Pick 5 or 6 variables with a mix of numeric and categorical variables and
#   make a ggpairs() plot. 
ggpairs(subset(credit,select=c(Income, Rating, Limit, Cards, Age, Gender)),
        ggplot2::aes(color=Gender))


#7. Use the variables you didn’t use in 6 to make 
#   another ggpairs() plot.
ggpairs(subset(credit,select=c(Education, Balance, Student, Married, County)),
        ggplot2::aes(color=County))