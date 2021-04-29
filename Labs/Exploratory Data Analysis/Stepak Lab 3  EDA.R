# The following program contains code for Lab 2 in
# Exploratory Data Analysis (EDA)
#
# @author   Sarah Stepak
# @program  Lab 3 EDA
# @since    03.16.2021
# @dataset cereal.csv

# import statements
library("hexbin")
library(ggplot2)
library(GGally)
library(viridis)

# Imports dataset
cereal <- cereal

# Creates a boxplot using manufacturer and one of the numeric variables. 
# Fills the boxes with a color of my choosing from Rcolor.pdf 
ggplot(cereal,aes(x=mfr, y=sugars)) +
  geom_boxplot(fill="lightblue")

# Creates a basic violin plot using shelf and one of the numeric variables. 
# Fills the boxes with a color and adds lines for the quantiles.
ggplot(cereal,aes(x=shelf,y=sodium)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75),fill="lightgreen")+
  theme_bw()

# Creates histograms with one of the numeric variables with the hot and cold cereals 
# on two side-by-side graphs. 
ggplot(cereal,aes(x=calories)) +
  geom_histogram() +
  facet_grid(type ~ .)

# Creates a frequency polygon using manufacturer and one of the numeric variables 
# and count on the y-axis.
ggplot(cereal, aes(x=calories, colour = mfr, linetype = mfr)) +
  geom_freqpoly()

# Create a frequency polygon using manufacturer and one of the numeric variables 
# and density on the y-axis.
ggplot(cereal, aes(x=protein, y=stat(density), colour = mfr)) +
  geom_freqpoly()

# Creates a hexbin plot using two of the numeric variables.
ggplot(cereal, aes(x=sodium, y=calories)) +
  geom_hex() +
  scale_fill_gradient(low = "blue", high = "orange")

# Create a scatterplot matrix for columns 4 through 10
cereal.matrix <- subset(cereal, select=c(4:10))
pairs(cereal.matrix)