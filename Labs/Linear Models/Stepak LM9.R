# This program contains code as well as responses to Linear Models Lab 9.
#
# @author   Sarah Stepak
# @program  Stepak LM9.R
# @since    04.24.2021
# @dataset  ipeds.small.public.csv

# Installs packages
# install.packages("car")

# Import statements
library(leaps)
library(car)
ipeds <- ipeds_smallpublic # dataset import

# Removes X1 col from data import
#temp <- ipeds[-c(1)]
#View(temp)
#ipeds <- temp
#View(ipeds)
#rm(temp)

ipeds.regsubsets.out <- regsubsets(RET_PCF ~ UAGRNTP + UPGRNTP + UFLOANP + UPGRNTA + UFLOANA +
                                   UAGRNTA + SATMT75 + SATVR75 + CINDON + COTSON + STUFACR + 
                                   PGREVCT + GRTOTLT, data=ipeds, nbest=1, nvmax=NULL,
                                   method = "exhaustive")

# Finds the best model with the adjusted R 2 criterion
#
# Prints the summary
ipeds.summary <- summary(ipeds.regsubsets.out)
cbind(ipeds.summary$which, adjr2=ipeds.summary$adjr2)

# Finds the max adjr2 values
max.adjr2 <- which.max(ipeds.summary$adjr2)
max.adjr2

# Plots the graph as well as a key
ipeds.summary$which[max.adjr2,]
subsets(ipeds.regsubsets.out, statistic="adjr2", legend=FALSE, min.size=3,
        main = "Adjusted R^2")




# Finds the best model with the Mallows C p criterion. Plots both graphs 
#
# Prints and plots the summary
cbind(ipeds.summary$which, cp=ipeds.summary$cp)
plot(ipeds.regsubsets.out, scale="Cp")

# Correction
P <- 1:length(ipeds.summary$cp)
cbind(P, P+1, ipeds.summary$cp)

# Plots the graph
subsets(ipeds.regsubsets.out, statistic="cp", legend=FALSE, min.size=3,
        main="Mallow's CP")