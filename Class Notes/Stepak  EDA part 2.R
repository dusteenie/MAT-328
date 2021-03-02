# The following program contains follow-up code for 
# Exploratory Data Analysis (EDA)
#
# @author   Dr. Sarah Hardy
# @author   Sarah Stepak
# @since    02.23.2021
# @dataset  super.csv   ipeds.csv

# Note, GGPlots are objects, and should be treated as such
 
#Import statements
library(ggplot2)
library(pdp)

# Makes a colored gradient graph  in regards to petal length
# Assigns these plots to object p1
p1 <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length, color = Sepal.Length)) +
  geom_point() +
  scale_color_gradient(low = "orange", high = "blue")

# Assigns these plots to object p2
# Makes a colored gradient graph in regards to sepal length
p2 <- ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Petal.Length)) +
  geom_point() +
  scale_colour_gradient(low = "green" , high="yellow")

# Creates a grid to plot multiple graphs, utilizes library pdp
grid.arrange(p1,p2,nrow=1,ncol=2)


# Setting aesthetics manually
# We can do size, color, shape, and opacity of a point
#
# Default settings
plot1 <- ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_point()
#
# Setting color and size manually
plot2 <- ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_point(color="blue",size=3)
#
# Setting the transparency manually with alpha property
plot3 <- ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_point(color="blue",size=3,alpha=.3)
#
# Using the geom_jitter geometry is also helpful when there are overlapping
# points.
plot4 <- ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_jitter(color="blue",size=3,alpha=.3)
#
# Arranges and plots all four graphs
grid.arrange(plot1,plot2, plot3, plot4, nrow=1, ncol=4)


# Graphs that look like "battleship" are unhelpful because
# You cannot see patterns. We don't get any information from them
# It occurs when you have two categorical variables 
# It's better to use bar plots for these
#
# Battleship graph
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()
#
# improved plot
ggplot(mpg,aes(x=class,y=drv)) +
  geom_jitter(color="blue",size=3,alpha=.3)


# plot traits are inherited!!
# In this plot the aes(color=class) mapping is done for the geom_points AND
# the geom_smooth
plot1 <- ggplot(mpg, aes(displ, hwy, color = class)) +
  geom_point() +
  geom_smooth(se = FALSE) #se=FALSE suppresses the band around the smooth
#
# In this plot the aes(color=class) mapping is done for the geom_points AND
# the geom_smooth
plot2 <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE)
#
grid.arrange(plot1, plot2, nrow=2, ncol=1)
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


# labs() 
# Typically this is added last
# labs() layer is used to add labels for the aesthetics 
#    (i.e., the x and y axes and the legend) and titles. 
# Note: You will need a plus sign after the geom_point() to add another layer.
# (Optional) Arguments to labs() - x= (label for the x-axis) - y= (label for the x-axis) - color=
# (label for a color legend) - title= - subtitle= - caption=
ggplot(mpg,aes(x=displ, y=hwy, color=class)) +
  geom_point() + 
  labs(x = "Displacement", y = "Highway MPG", color="Vehicle Class",
       title="Displacement vs Highway MPG",
       subtitle='Sarah Hardy - 2/27/2020',
         caption='EPA Fuel Economy Data - 1999-2008')

# themes()
# There are four built-in themes: 
#     theme_grey() (the default theme) 
#     theme_bw() 
#     theme_classic() 
#     theme_minimal() 
p1 <- ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_point()+
  labs(title="Default theme")
#
p2 <- ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_point()+
  theme_bw()+
  labs(title="theme_bw()")
#
p3 <- ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_point()+
  theme_classic()+
  labs(title="theme_classic()")
#
p4 <- ggplot(mpg, aes(x=displ,y=hwy)) +
  geom_point()+
  theme_minimal()+
  labs( title="theme_minimal()")
#
# Plots the grids
grid.arrange(p1,p2,p3,p4, ncol=2,padding=1)


# facet_grid()
# Remember to use catagoracal variables!
# Make separate plots by different values of a third (and fourth) variable. 
# A big advantage of this method is that the multiple plots are made 
#   with the same x and y axes for straight forward comparison.
# When plots are made separately, the default is for R to spread the
# data out along the axes as much as possible and plots will not be directly 
# comparable if they are not on the same scale.
#
# Plot grid with drv in y direction and as.factor(cyl) in x direction"
ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_point()+
  facet_grid(drv~as.factor(cyl))
#
# Plot grid with as.factor(cyl) in x direction (and nothing in the y direction)
ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_point()+
  facet_grid( . ~as.factor(cyl))
#
# with drv in y direction (and nothing in the x direction)
ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_point()+
  facet_grid(drv~ .)
#
#ggplot(mpg,aes(x=displ,y=hwy,color=class)) +
geom_point()+
  facet_grid( . ~ class)



# Bar charts for one categorical variable
#
super <- "super.csv"
#View(super)
#table(super$Alignment)
#table(super$Race)
super$Alignment <- ordered(super$Alignment,c("good","neutral","bad"))
super <- within(super,{ 
  race.cat <- NA
  race.cat[Race=="Human"] <- "Human"
  race.cat[Race=="Mutant"] <- "Mutant"
  race.cat[substring(Race,1,6)=="Human/"] <- "Human/Other"
  race.cat[is.na(race.cat)] <- "Other"
})
table(super$race.cat,exclude=NULL)
#
plot1 <- ggplot(super, aes(x = Alignment)) +
  geom_bar()
#
plot2 <- ggplot(super, aes(y = Alignment)) +
  geom_bar(fill="turquoise",na.rm=TRUE)
#
grid.arrange(plot1, plot2, nrow=1, ncol=2)


# Bar charts for two categorical variables
#
table(super$race.cat,super$Alignment,exclude=NULL)
# There are 3 choices:
#    Stacked as counts - geom_bar() - the default
#    Stacked as percentage - geom_bar(position=“fill”)
#    Side-by-side - geom_bar(position=“dodge”)
#
# Stacked as counts
ggplot(super, aes(x = Alignment, fill = race.cat)) +
  geom_bar()+
  labs(title="Stacked as counts",subtitle="default")
#
# Stacked as percentage
ggplot(super, aes(x = Alignment, fill = race.cat)) +
  geom_bar(position="fill")+
  labs(title="Stacked as %'s",subtitle='position="fill"')
#
# Side by Side
ggplot(super, aes(x = Alignment, fill = race.cat)) +
  geom_bar(position="dodge")+
  labs(title="Side-by-side",subtitle='position="dodge"')
#
# Same variables switching the mappings of x= and fill=
ggplot(super, aes(x = race.cat, fill = Alignment)) +
  geom_bar()
ggplot(super, aes(x = race.cat, fill = Alignment)) +
  geom_bar(position="fill")
ggplot(super, aes(x = race.cat, fill = Alignment)) +
  geom_bar(position="dodge")

