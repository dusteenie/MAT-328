# The following program contains code and notes for 
# the second linear models part
#
# @author   Dr. Sarah Hardy
# @author   Sarah Stepak
# @program  Linear Models 2.R
# @since    03.16.2021
# @dataset Advertising.xlsx

ad <- Advertising.xlsx

# lm means linear model
# y~x   means a function of
# wind.lm   out of object
# It will do the first four residual plots automatically unleass you tell it otherwise
wind.lm <- lm(NO2~windspeed,data=windspeed)
summary(wind.lm)
plot(wind.lm) # this will add the four residual plots to the  plot window

library(ggplot2)
ggplot(windspeed,aes(x=windspeed,y=NO2))+
  geom_point()+
  geom_smooth(method="lm")
