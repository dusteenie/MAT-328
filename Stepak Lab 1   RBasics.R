# @author Sarah Stepak
# @since  01.27.2021
# The dataset is low birth-weight infant script 
# Data provided by Dr. S. Hardy.

#Shows the mean of of col 'BWT'
mean(lowbirthwt$BWT)

#Plots a histogram of col 'BWT'
hist(lowbirthwt$BWT, col="lightblue", main="Birth Weight", xlab="Weight (gm)", ylab="frequency")

#Plots a graph comparing birth-weight to the weight of the mother (lbs)
plot(lowbirthwt$BWT~lowbirthwt$LWT, main ="Dusty Stepak", xlab="Weight of the Mother (lbs)", ylab="Birth-Weight (lbs)")

#Plots a boxplot comparing birth-weight to smoking status during pregnancy 
boxplot(lowbirthwt$BWT~lowbirthwt$SMOKE, main="Dusty Stepak", xlab="Smoking Status of Mother", ylab="Birth-Weight (lbs)")
