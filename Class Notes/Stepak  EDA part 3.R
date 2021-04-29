# The following program contains class notes / code for
# Exploratory Data Analysis (EDA)
#
# @author   Dr. Sarah Hardy
# @author   Sarah Stepak
# @program  EDA Class Notes 3
# @since    03.04.2021
# @dataset ipeds.csv

# import statements
library("hexbin")
library(ggplot2)
library(GGally)
library(viridis)


# Note:If x or y is missing, the observation is not plotted
ggplot(ipeds,aes(x=UFLOANA,y=CINDON,color=UAGRNTA)) +
  geom_point() +
  scale_colour_gradient(low = "orange", high = "blue")
## Warning: Removed 471 rows containing missing values (geom_point).
#
table(is.na(ipeds$UFLOANA), is.na(ipeds$CINDON))


# If the 3rd continuous variable variable mapped to color is missing, the
# point is plotted without color, i.e. it is grey.
ggplot(ipeds,aes(x=UFLOANA, y=CINDON,color=SATMT75))+
  geom_point()+
  scale_colour_gradient(low="orange",high="blue")
## Warning: Removed 471 rows containing missing values (geom_point).
table(is.na(ipeds$UFLOANA) | is.na(ipeds$CINDON)| is.na(ipeds$SATMT75))


#What if you don’t want the observations with a missing value plotted on the plot?
#Plot a subset of the data
ggplot(subset(ipeds,!is.na(SATMT75)),aes(x=UFLOANA,y=CINDON,color=SATMT75)) +
  geom_point() +
  scale_colour_gradient(low = "orange", high = "blue")+
  labs(caption="841 observations were not plotted due to missing values")
## Warning: Removed 32 rows containing missing values (geom_point).


# ggplot has built-in color palettes
# rainbow is a built-in palette
ggplot(mpg,aes(x=displ,y=hwy,color=class)) + 
  geom_point() + 
  scale_color_manual(values=rainbow(7)) #the 7 is because we want 7 colors


# fill aesthetic
# The fill aesthetic is just like the color 
# aesthetic, except it is used for areas instead of points. Only categorical/discrete variables can be mapped to the fill aesthetic.
#
# Gradient color
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width))+
  geom_point(aes(color = Sepal.Length)) +
  scale_color_viridis(option = "D")
#
# For discrete colors use the argument discrete = TRUE
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width))+
  geom_point(aes(color = Species)) +
  geom_smooth(aes(color = Species, fill = Species)) +
  scale_color_viridis(discrete = TRUE, option = "D")+
  scale_fill_viridis(discrete = TRUE) 
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
#There are 4 other available colormap options:
# “magma” (or “A”), “inferno” (or “B”),
# “plasma” (or “C”), and “cividis” (or “E”).

# --------------------------------------------------------

# Plotting one continuous/numeric variable and one 
# categorical/discrete variable
#
#Possible ways:
# Boxplots with geom_boxplot()
# Violin plots with geom_violin()
# Histograms with geom_histogram() and facet_grid()
# Frequency polygons with geom_freqpoly()


#Boxplots with geom_boxplot()
#basic boxplot
ggplot(ipeds,aes(x=control.cat,y=UPGRNTA)) +
  geom_boxplot()
## Warning: Removed 15 rows containing non-finite values (stat_boxplot).
#
#to color
ggplot(ipeds,aes(x=control.cat,y=UPGRNTA)) +
  geom_boxplot(fill="palegreen")
## Warning: Removed 15 rows containing non-finite values (stat_boxplot).


# Violin plots with geom_violin()
# Violin plots are similar to boxplots, but they 
# show more detail regarding the shape of the distribution.
#
# a variation on a boxplot called a violin plot
ggplot(ipeds,aes(x=control.cat,y=UPGRNTA)) +
  geom_violin()
#
# Violin plot with quantiles and color.
ggplot(ipeds,aes(x=control.cat,y=UPGRNTA)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75),fill="gold")+
  theme_bw()


# Histograms with facet_grid()
# Draw separate histograms by each category of a categorical variable for comparison
ggplot(ipeds,aes(x=RET_PCF)) +
  geom_histogram()+
  facet_grid(control.cat ~ .)
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## Warning: Removed 175 rows containing non-finite values (stat_bin).


#Frequency polygon with geom_freqpoly()
#Frequency Polygon with counts - basic version.
ggplot(ipeds, aes(x=RET_PCF, color = control.cat)) +
  geom_freqpoly()
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## Warning: Removed 175 rows containing non-finite values (stat_bin).
#
#Frequency Polygon with counts - tweaked
ggplot(ipeds, aes(x=RET_PCF, color = control.cat,linetype=control.cat)) +
  geom_freqpoly(lwd=2)+
  theme_bw()
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
#
#Frequency Polygon with density - tweaked.
ggplot(ipeds, aes(x=RET_PCF, y=stat(density), color = control.cat)) +
  geom_freqpoly()
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.


#Revisit over-plotting on scatter plots
#hexbin() for over-plotting in scatterplots with many observations
county <- read.csv("county.csv")
names(county) <- gsub(" ",".",names(county))

p1 <- ggplot(county, aes(x=Teen.births,y=Less.Than.High.School.Diploma)) +
  geom_point()
p2 <- ggplot(county, aes(x=Teen.births,y=Less.Than.High.School.Diploma)) +
  geom_jitter(color="blue",alpha=0.3)
grid.arrange(p1,p2,ncol=2)
#
# The light area means a LOT of observations
ggplot(county, aes(x=Teen.births,y=Less.Than.High.School.Diploma)) +
  geom_hex()
#
# Adding our own color scheme
p1 <-ggplot(county, aes(x=Teen.births,y=Less.Than.High.School.Diploma)) +
  geom_hex()+
  scale_fill_gradient(low = "blue", high = "orange")
p2 <- ggplot(county, aes(x=Teen.births,y=Less.Than.High.School.Diploma)) +
  geom_hex()+
  scale_fill_viridis()
grid.arrange(p1,p2,nrow=1,ncol=2)  


#Scatterplot matrix with pairs()
# tHIS IS BASE R  
#Useful for finding patterns, especially with a large number of numeric variables (although it will substitute integers for categories if given a categorical variable). Note: This is not part of ggplot2!
ipeds.sub <- subset(ipeds,STUFACR < 40 & RET_PCF < 99,
                      select=c(RET_PCF,UPGRNTA,STUFACR,SATMT75))
pairs(ipeds.sub)