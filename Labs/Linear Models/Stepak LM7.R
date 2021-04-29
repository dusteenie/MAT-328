# The following program contains code and notes for lab LM 7
#
# @author   Sarah Stepak
# @program  Stepak LM7.R
# @since    04.13.2021
# @dataset  CreditV3.csv
# @dataset  ipeds.small.public.csv


# Import statements
library(GGally)
library(ggplot2)
credit <- CreditV3 #dataset import
ipeds <- ipeds_smallpublic #dataset import


# Using dataset CreditV3
# ------------------------------------------------------------------------------
# Creates a model with Balance as the response variable and Income and Student 
#  as predictor variables including the interaction term. Graphs the results.
#
lm.BalanceIncomeStudent <-lm(Balance~Income+Student, data=credit)
summary(lm.BalanceIncomeStudent)
credit$pred.BalanceIncomeStudent <- predict(lm.BalanceIncomeStudent)

ggplot(data=credit, aes(x=Income,y=Balance, color=Student))+
  geom_point()+
  geom_line(aes(y=pred.BalanceIncomeStudent))+
  theme_bw()


# Creates a model with Balance as the response variable and Income and County as
#  predictor variables including the interaction term. Graphs the results.
#
lm.BalanceIncomeCounty <- lm(Balance~(Income+County), data=credit)
summary(lm.BalanceIncomeCounty)
credit$pred.BalanceIncomeCounty <- predict(lm.BalanceIncomeCounty)

ggplot(data=credit, aes(x=Income,y=Balance, color=County))+
  geom_point()+
  geom_line(aes(y=pred.BalanceIncomeCounty))+
  theme_bw()


# Creates a model with Balance as the response variable and Income, Student and
# County as predictor variables including all interaction terms. 
# Graphs the results
#
lm.BalIncomeStudentCounty <- lm(Balance~(Income+Student+County)^2,data=credit)
summary(lm.BalIncomeStudentCounty)
credit$pred.BalIncomeStudentCounty <- predict(lm.BalIncomeStudentCounty)

ggplot(data=credit, aes(x=Income, y=Balance, color=Student, linetype=County))+
  geom_point()+
  geom_line(aes(y=pred.BalIncomeStudentCounty))+
  theme_bw()


#d. Summarize your results in a paragraph.
#   The model shows little correlation with Balance as the response variable 
#   and Income and Student as predictor variables. A model with Balance as the 
#   response variable and Income and County as predictor variables also shows little
#   correlation. For both of these models, the line of best fit shows a lot of varience.
#   When looking at the third plot, It appears that the same amount of students live in
#   counties A, B, while there is the same number of non students living in counties
#   A,B,C up to 100 Income.



#2. Using dataset ipeds.small.public
# ------------------------------------------------------------------------------
# Creates a backward elimination to build a model for predicting retention. 
# Uses .05 as cutoff.
lm.ipeds <- lm(RET_PCF~UAGRNTP+UPGRNTP+UFLOANP+UPGRNTA+UFLOANA+UAGRNTA+
                 SATMT75+SATVR75+CINDON+COTSON+STUFACR+PGREVCT+GRTOTLT,
                 data=ipeds)
summary(lm.ipeds)
# Index to cut: 0,1,2,3,4,6,10,11
# result:
lm.ipeds <- lm(RET_PCF~UAGRNTA+SATVR75+CINDON+COTSON+GRTOTLT,data=ipeds)
summary(lm.ipeds)


# Graphs the variables in your final model with ggpairs.
ggpairs(lm.ipeds)
