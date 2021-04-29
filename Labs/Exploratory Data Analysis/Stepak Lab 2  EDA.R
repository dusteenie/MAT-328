# The following program contains code for Lab 2 in
# Exploratory Data Analysis (EDA)
#
# @author   Sarah Stepak
# @program  Lab 2 EDA
# @since    03.02.2021
# @dataset ipeds.csv


# Import statements
library(ggplot2)
library(pdp)

# Imports data
ipeds <- ipeds


# Chooses three of the numeric variables and map them aesthetics 
# x, y and color and creates a color gradient (see R color list in EDA folder).
# Adds labels to the plot.
#
ggplot(ipeds, aes(x=SATMT75, y=SATVR75, color=UAGRNTA )) +
  geom_point() +
  scale_color_gradient(low="orange", high="blue")+
  labs(title="Math to English SAT Score in Comparison to", 
       subtitle="Average amount of federal  state  local  institutional or other sources of grant aid awarded" )


# Chooses two of the numeric variables and sets: color, size, and alpha manually like the
# example on page 4.
#
ggplot(ipeds, aes(x=RET_PCF, y=STUFACR)) + 
  geom_point(color="red", size=2, alpha=.4)


# Repeat one of the earlier plots (your choice) with the 4 different themes and 
# put the 4 plots in a 2x2 grid using the grid.arrange function 
#
#Default
plot1 <- ggplot(ipeds, aes(x=RET_PCF, y=STUFACR)) + 
  geom_point()
#Black and White
plot2 <- ggplot(ipeds, aes(x=RET_PCF, y=STUFACR)) + 
  geom_point() +
  theme_bw()
#Classic
plot3 <- ggplot(ipeds, aes(x=RET_PCF, y=STUFACR)) + 
  geom_point() +
  theme_classic()
#Minimal 
plot4 <- ggplot(ipeds, aes(x=RET_PCF, y=STUFACR)) + 
  geom_point() +
  theme_minimal()
#Plots plots 1-4 in a 2x2 grid
grid.arrange(plot1,plot2, plot3, plot4, nrow=2, ncol=2)
#Removes plots 1-4.
rm(plot1,plot2, plot3, plot4)


# Chooses two of the numeric variables and one categorical and makes two plots: 
#     a) one with different smooths for each categorical value
#     b) one with a single smooth. (see page 6)
#
#Plot 1
plot1 <- ggplot(ipeds, aes(UPGRNTP, UFLOANP, color=locale.cat)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
plot1
#Plot 2
plot2 <- ggplot(ipeds, aes(UPGRNTP, UFLOANP)) + 
  geom_point(aes(color = locale.cat)) + 
  geom_smooth(se = FALSE)
#Plots plots 1,2 in a 1x2 grid
grid.arrange(plot1,plot2, nrow=1, ncol=2)
#Removes plots 1,2.
rm(plot1,plot2)



# Chooses two numeric variables and uses facet_grid() create separate plots for
# each control.cat. (Also maps control.cat to color).
#
plot1 <- ggplot(ipeds, aes(UPGRNTP, UFLOANP)) + 
  geom_point(aes(color = control.cat))  +
  facet_grid(control.cat ~.)
plot1


# Repeats the above with locale.cat.
#
plot2 <- ggplot(ipeds, aes(UPGRNTP, UFLOANP)) + 
  geom_point(aes(color = locale.cat))  +
  facet_grid(locale.cat ~.)
plot2


# Repeats the above with putting control.cat and locale.cat in one grid.
#
grid.arrange(plot1,plot2, nrow=1, ncol=2)
#Removes plots 1,2.
rm(plot1,plot2)


# Creates 6 barcharts with control.cat and locale.cat. 
#
# Default Alignment
# p1 - default
plot1 <- ggplot(ipeds, aes(x = control.cat, fill = locale.cat)) +
  geom_bar()
# p2 - fill 
plot2 <- ggplot(ipeds, aes(x = control.cat, fill = locale.cat))+
  geom_bar(position="fill")
# p3 - dodge
plot3 <- ggplot(ipeds, aes(x = control.cat, fill = locale.cat)) +
  geom_bar(position="dodge")
# Switched Alignment
# p4 - default
plot4 <-ggplot(ipeds, aes(x = locale.cat, fill = control.cat)) +
  geom_bar()
# p5 - fill
plot5 <- ggplot(ipeds, aes(x = locale.cat, fill = control.cat))+
  geom_bar(position="fill")
# p6 - dodge
plot6 <- ggplot(ipeds, aes(x = locale.cat, fill = control.cat)) +
  geom_bar(position="dodge")
#Plots plots 1-6 in a 2x3 grid
grid.arrange(plot1,plot2, plot3, plot4, plot5, plot6, nrow=2, ncol=3)
#Removes plots 1-6.
rm(plot1,plot2, plot3, plot4, plot5, plot6)

# RESPONSE:
#     Q: If you had to choose one of the 6 for a presentation which would you choose and why?
#     A: I would choose the switched dodge because in my opinion it's easier to read.
