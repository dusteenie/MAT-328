# This program contains code as well as responses to 
# Classification Trees Lab 1.
#
# @author   Dr. Sarah Hardy
# @author   Sarah Stepak
# @program  Stepak CT1.R
# @since    05.01.2021
# @dataset  elect2016.csv
# @dataset  ipeds


# Import statements
library(rpart)
library(rpart.plot)
elect2016_for_lab <- elect2016 # dataset import
iped <- ipeds # dataset import

# Runs provided snippet - Written by Dr. Sarah Hardy
names(elect2016_for_lab)
elect2016 <- elect2016_for_lab[,-c(1:5)]

# Using the dataset, fits an rpart model that predicts Candidate
# based on all of the other variables. 
names(elect2016)
table(elect2016$Candidate)

set.seed(6762)
rpart.candidate <- rpart(Candidate~School_Enrollment+ Median_Earnings_2010+
                         Poor.physical.health.days+ Poor.mental.health.days+ 
                         Low.birthweight+ Teen.births+ 
                         Children.in.single.parent.households+ Adult.smoking+
                         Adult.obesity+ Diabetes+ Sexually.transmitted.infections+
                         HIV.prevalence.rate+ Uninsured+ Unemployment+ 
                         Violent.crime+ Homicide.rate+ Injury.deaths+ 
                         Infant.mortality+ precip,
                         data = elect2016, method="class")
printcp(rpart.candidate)

# xerror is not reaching a min, so I am going to grow the tree.
# xerror = 0.74315
#
# Grows the tree
set.seed(6762)
rpart.candidate <- rpart(Candidate~School_Enrollment+ Median_Earnings_2010+
                           Poor.physical.health.days+ Poor.mental.health.days+ 
                           Low.birthweight+ Teen.births+ 
                           Children.in.single.parent.households+ Adult.smoking+
                           Adult.obesity+ Diabetes+ Sexually.transmitted.infections+
                           HIV.prevalence.rate+ Uninsured+ Unemployment+ 
                           Violent.crime+ Homicide.rate+ Injury.deaths+ 
                           Infant.mortality+ precip,
                         data = elect2016, method="class", cp=0.001)
printcp(rpart.candidate)

# Prunes the tree
set.seed(6762)
rpart.candidate <- rpart(Candidate~School_Enrollment+ Median_Earnings_2010+
                           Poor.physical.health.days+ Poor.mental.health.days+ 
                           Low.birthweight+ Teen.births+ 
                           Children.in.single.parent.households+ Adult.smoking+
                           Adult.obesity+ Diabetes+ Sexually.transmitted.infections+
                           HIV.prevalence.rate+ Uninsured+ Unemployment+ 
                           Violent.crime+ Homicide.rate+ Injury.deaths+ 
                           Infant.mortality+ precip,
                         data = elect2016, method="class", cp=0.00342466)
printcp(rpart.candidate)


pred.candidate <- predict(rpart.candidate, type="class")
confusion <- table(Actual=elect2016$Candidate, Predicted=pred.candidate)
confusion

# Correct classification rate
sum(diag(confusion)) / sum(confusion)

# Plots the rpart model
rpart.plot(rpart.candidate, type=4, extra=2, under=T)



# Runs provided snippet - Written by Dr. Sarah Hardy
ipeds2 <- iped[,c('UAGRNTP','UPGRNTP','UFLOANP','UPGRNTA','UFLOANA',                 
       'UAGRNTA','SATMT75','SATVR75','CINDON','COTSON','CINSOFF','COTSOFF',                  
       'EFAGE09','RET_PCF','STUFACR','PGREVCT','GRTOTLT','control.cat',
       'locale.cat','size.cat','disab.cat')]

# Fits an rpart model which predicts control.cat based on all of the other
# variables
set.seed(1)
rpart.iped <- rpart(control.cat~UAGRNTP+ UPGRNTP+ UFLOANP+ UPGRNTA+ UFLOANA+                 
                    UAGRNTA+ SATMT75+ SATVR75+ CINDON+ COTSON+ CINSOFF+ COTSOFF+                  
                    EFAGE09+ RET_PCF+ STUFACR+ PGREVCT+ GRTOTLT+
                    locale.cat+ size.cat+ disab.cat+ control.cat,
                    data = ipeds2, method="class")
printcp(rpart.iped)


# Grows / prunes the tree as necessary
set.seed(1)
rpart.iped <- rpart(control.cat~UAGRNTP+ UPGRNTP+ UFLOANP+ UPGRNTA+ UFLOANA+                 
                      UAGRNTA+ SATMT75+ SATVR75+ CINDON+ COTSON+ CINSOFF+ COTSOFF+                  
                      EFAGE09+ RET_PCF+ STUFACR+ PGREVCT+ GRTOTLT+
                      locale.cat+ size.cat+ disab.cat+ control.cat,
                    data = ipeds2, method="class", cp=0.001)
printcp(rpart.iped)
rpart.plot(rpart.iped, type=4, extra=2, under=T)
