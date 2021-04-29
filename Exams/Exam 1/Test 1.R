# The following program contains code for Test 1
#
# @author   Sarah Stepak
# @program  Test 1.R
# @since    03.17.2021
# @dataset  metro.csv

# Import statements
library("hexbin")
library(ggplot2)
library(GGally)
library(viridis)
library(pdp)

# Imports and examines the dataset
m <- metro
dim(m)  
names(m)
summary(m)

# Problem 1
# Using metro$river, creates a new var river.yn which contains 
# values Yes / No.
temp <- within(m, {
  yn <- NA
  yn [river == 0] <- "No"
  yn [river == 1] <- "Yes"
})
# DEBUG / Testing
#  dim(temp)
#  names(temp)
#  temp$yn
m$river.yn <- temp$yn
rm(temp)

# Problem 2
# Using metro, creates a new var named locale.
#    Label          Constraint 
#    City Center    Distance from employment < 2
#    City Outer     Distance from employment < 6
#    Suburban       Distance from employment < 9
#    Rural          Distance from employment >= 9
temp <- within(m, {
  locale <- NA
  locale [dis < 2] <- "City Center"
  locale [dis >= 2 & dis < 6] <- "City Outer"
  locale [dis >= 6 & dis < 9] <- "Suburban"
  locale [dis >= 9] <- "Rural"
})
# DEBUG / Testing
#  dim(temp)
#  names(temp)
#  temp$locale
m$locale <- temp$locale
rm(temp)

# Problem 3
# Makes a graph showing the relationship between two of the 
# numeric variables as well as highway.
p1 <- ggplot(m,aes(x=zn,y=nox)) +
  geom_point(aes(color = nox)) +
  scale_color_viridis(option = "D") +
  facet_grid( . ~as.factor(highway)) +
  labs(title = "Nitrogen Oxide concentration to Proportion of Residential Land",
       subtitle = "In relation to Highway Accessability.",
       caption = "Visualized by Sarah Stepak")
p1

# Problem 4
# Makes a graph showing the relationship between two of the 
# numeric variables (except for zn,) as well as river.yn
p2 <- ggplot(m,aes(x=tax,y=ptratio)) +
  geom_point(aes(shape = factor(river.yn), colour = factor(river.yn))) +
  labs(title = "Property Tax to Pupil-Teacher Ratio by District",
       subtitle = "In relation to Riverbound Tracts.",
       caption = "Visualized by Sarah Stepak",
       colour = "Tract is Riverbound",
       shape = "Tract is Riverbound")
p2

# Problem 5
# Makes a graph with 3 numerical vars and maps them to aesthetics:
# x, y, color. Creates my own color gradient.
p3 <- ggplot(m,aes(x=tax, y=medv)) +
  geom_point(aes(colour=medv)) +  
  scale_colour_gradient(low="lightblue", high="purple") +
  labs(title = "Property Tax to Property Value",
       subtitle = "In relation to the Mean Distance to Employment Centers.",
       caption = "Visualized by Sarah Stepak")
p3

# Problem 6
# Chooses two of the numeric variables and using facet_grid(), creates 
# separate plots for each locale created in question 2. Also maps locale to color.
p4 <- ggplot(m,aes(x=medv,y=age)) +
  geom_point(aes(colour=medv)) +  
  scale_colour_gradient(low="lightblue", high="red") +
  facet_grid( . ~as.factor(locale)) +
  labs(title = "Property Value to Owner occupied Units built prior to 1940",
       subtitle = "In relation to Property Locale.",
       caption = "Visualized by Sarah Stepak",
       colour = "Property Value")
p4

# Problem 7
# Makes a graph showing the relationship between two of the categorical variables.
p5 <- ggplot(m, aes(x=highway, fill=river.yn)) +
  geom_bar() +
  labs(title = "Highway Access in comparison to Riverbound Tracts",
       caption = "Visualized by Sarah Stepak",
       fill = "Tract is Riverbound")
p5

# Problem 8
# Makes a graph showing the relationship between one of the categorical variables 
# and one of the numeric variables.
p6 <- ggplot(m, aes(x=highway, y=nox)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75), fill="lightgreen") +
  labs(title = "Highway Access to Nitrogen Oxide concentration",
       subtitle = "Quantiles at 0.25, 0.5, 0.75",
       caption = "Visualized by Sarah Stepak")
p6

# Problem 9
# Makes a plot with two numeric variables using the geom_hexbin geometry.
p7 <- ggplot(m, aes(x=zn, y=age)) +
  geom_hex() +
  scale_fill_gradient(low = "lightblue", high = "magenta") +
  labs(title = "Proportion of Zoned Lot to Owner occupied Units built prior to 1940",
       subtitle = "Zoned Lots are greater than 25,000 sq.ft",
       caption = "Visualized by Sarah Stepak")
p7

