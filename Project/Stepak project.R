# This program contains code for part 2 of the project. Analyzes and 'cleans'
# data, creates tables, and creates charts to depict patterns.
#
# @author   Sarah Stepak
# @program  Stepak project.R
# @since    03.31.2021
# @dataset  Solar_Electric_Programs_Reported_by_NYSERDA__Beginning_2000.csv


# Import statements
library(ggplot2)
library(GGally)
library(viridis)
library(pdp)
library(grid)
library(vcd)
solar <- Solar_Electric_Programs #dataset


# Dataset summary
dim(solar) #Prints the dataset dimensions
names(solar) #Prints all of the col names
str(solar) #Prints the datatype of each col
summary(solar) #Overall summary of the dataset


# Standardizes the formatting of categorical columns: 'City' , 'County' , 
# 'Primary Inverter Manufacturer', 'Primary PV Module Manufacturer', 
# 'Solicitation' in dataset solar. Upon completion: checks the length of the vector.
#
# City
temp <- toupper(solar$City)
temp <- gsub(" ", ".",temp)
length(solar$City)
length(temp)
solar$City <- temp
rm(temp)
# County
temp <- toupper(solar$County)
temp <- gsub(" ", ".",temp)
length(solar$City)
length(temp)
solar$County <- temp
rm(temp)
#Primary Inverter Manufacturer
temp <- toupper(solar$`Primary Inverter Manufacturer`)
temp <- gsub(" ", ".",temp)
length(solar$`Primary Inverter Manufacturer`)
length(temp)
solar$`Primary Inverter Manufacturer` <- temp
rm(temp)
#Primary PV Module Manufacturer
temp <- toupper(solar$`Primary PV Module Manufacturer`)
temp <- gsub(" ", ".",temp)
length(solar$`Primary PV Module Manufacturer`)
length(temp)
solar$`Primary PV Module Manufacturer` <- temp
rm(temp)
# Solicitation
temp <- toupper(solar$Solicitation)
temp <- gsub(" ", ".",temp)
length(solar$Solicitation)
length(temp)
solar$Solicitation <- temp
rm(temp)


# Investigates categorical columns: 'City' , 'County' , 'Primary Inverter Manufacturer',
# 'Primary PV Module Manufacturer', 'Project Status', 'Solicitation' in dataset solar. 
# Each investigation does the following: Prints the total number of null values,
# sorts and shows all unique values
#
# City
sum(is.na(solar$City))
table(sort(unique(solar$City)))
# County
sum(is.na(solar$County))
table(sort(unique(solar$County)))
#Primary Inverter Manufacturer
sum(is.na(solar$`Primary Inverter Manufacturer`))
table(sort(unique(solar$`Primary Inverter Manufacturer`)))
#Primary PV Module Manufacturer
sum(is.na(solar$`Primary PV Module Manufacturer`))
table(sort(unique(solar$`Primary PV Module Manufacturer`)))
# Project Status
sum(is.na(solar$`Project Status`))
table(sort(unique(solar$`Project Status`)))
# 'Solicitation'
sum(is.na(solar$Solicitation))
table(sort(unique(solar$Solicitation)))


# Uses within() to remap values in Project status into var is.complete for
# readability. Changes variable values: complete, pipeline to Completed, 
# Incomplete; respectfully.
#
temp <- within(solar,{
  is.complete <- NA
  is.complete [`Project Status` == "Complete" | `Project Status` == "complete"] <- "Completed"
  is.complete [`Project Status` == "Pipeline" | `Project Status` == "pipeline"] <- "Incomplete" 
})
table(sort(temp$is.complete)) #error checking
solar$Status <- temp$is.complete
rm(temp)


# Creates three tables to compare project completeness to : county, city and 
# solicitation respectfully.
#
table(solar$County, solar$Status)
table(solar$City, solar$Status)
table(solar$Solicitation, solar$Status)


# Creates tables to compare: Affordability to Total Cost, `Total Inverter Quantity`
# to `Total PV Module Quantity`, and Total Cost to Project Completion; Respectfully.
#
table(solar$`Affordable Solar`, solar$`Project Cost`)
table(solar$`Total Inverter Quantity`,solar$`Total PV Module Quantity`)
table(solar$`Project Cost`,solar$Status)


# The following tables compare categorical columns: 'City' , 'County' , 
# 'Primary Inverter Manufacturer', 'Primary PV Module Manufacturer', 
# 'Project Status', 'Solicitation' to NY's Green Jobs Participanty, As well as Affordability. 
#
# County
table(solar$County, solar$`Green Jobs Green New York Participant`)
table(solar$County, solar$`Affordable Solar`)
# City
table(solar$City, solar$`Green Jobs Green New York Participant`)
table(solar$City, solar$`Affordable Solar`)
# 'Primary Inverter Manufacturer'
table(solar$'Primary Inverter Manufacturer', solar$`Green Jobs Green New York Participant`)
table(solar$'Primary Inverter Manufacturer', solar$`Affordable Solar`)
# 'Primary PV Module Manufacturer'
table(solar$'Primary PV Module Manufacturer', solar$`Green Jobs Green New York Participant`)
table(solar$'Primary PV Module Manufacturer', solar$`Affordable Solar`)
# 'Project Status'
table(solar$'Project Status', solar$`Green Jobs Green New York Participant`)
table(solar$'Project Status', solar$`Affordable Solar`)
# 'Solicitation'
table(solar$'Solicitation', solar$`Green Jobs Green New York Participant`)
table(solar$'Solicitation', solar$`Affordable Solar`)


# The following creates tables comparing variables: `Total Inverter Quantity` ,  
# `Total PV Module Quantity` , `Total Nameplate kW DC` , and `Project Cost` to 
# `Expected KWh Annual Production`. 
# NOTE: These tables are later visualized by a set of graphs. Due to their 
#       size and lack of readability, they have been commented out.
#
#table(solar$`Total Inverter Quantity`, solar$`Expected KWh Annual Production`)
#table(solar$`Total PV Module Quantity`, solar$`Expected KWh Annual Production`)
#table(solar$`Total Nameplate kW DC`, solar$`Expected KWh Annual Production`)
#table(solar$`Project Cost`, solar$`Expected KWh Annual Production`)


# Creates a graph which depicts total project cost in comparison to 
# total incentive (in US Dollars,) as well as expected annual KW/h production.
# Split findings by project status. 
#
ggplot(solar, aes(x=`Project Cost`, y=`$Incentive`)) +
  geom_jitter(aes(color = `Expected KWh Annual Production`)) +
  facet_grid( . ~as.factor(Status)) +
  labs(title = "Project Cost by Incentive, in comparison to Expected KW/h Production",
       subtitle = "Split by Project Completion.",
       caption = "Visualized by Sarah Stepak")


# Creates a graph which depicts total project cost in comparison to 
# total incentive (in US Dollars,) as well as expected annual KW/h production.
# Split findings by affordability. 
#
ggplot(solar, aes(x=`Project Cost`, y=`Expected KWh Annual Production`)) +
  geom_jitter(aes(color = `County`)) +
  facet_grid( . ~as.factor(`Affordable Solar`)) +
  labs(title = "Project Cost by Expected KW/h Production, in comparison to County",
       subtitle = "Split by Affordability.",
       caption = "Visualized by Sarah Stepak")


# Creates a graph which depicts total PV Module quantity in comparison to 
# total Nameplate kW DC. Color is determined by the expected KWh production.
#
ggplot(solar, aes(x=`Total PV Module Quantity`, y=`Total Nameplate kW DC`)) +
  geom_point(aes(color=`Expected KWh Annual Production`)) +
  geom_smooth(method = "lm", color = "red", size=1) +
  labs(title = "Total PV Module Quantity by Total Nameplate kW DC",
       subtitle = "Compaired to the Expected KW/h Production",
       caption = "Visualized by Sarah Stepak")


# Creates four graphs and places them side by side to observe any similarities 
# or differences when comparing variables: `Total Inverter Quantity` , `Total PV Module Quantity` , 
# `Total Nameplate kW DC` , and `Project Cost` to `Expected KWh Annual Production`
#
#`Total Inverter Quantity` 
plot1 <- ggplot(solar, aes(x=`Total Inverter Quantity`, y=`Expected KWh Annual Production`)) +
  geom_point(color='blue', alpha = 0.50, show.legend = FALSE) +
  labs(title = "Total Inverter Quantity, in comparison to Expected KW/h Production",
       subtitle = "",
       caption = "Visualized by Sarah Stepak")
#`Total PV Module Quantity` 
plot2 <- ggplot(solar, aes(x=`Total PV Module Quantity`, y=`Expected KWh Annual Production`)) +
  geom_point(color='blue', alpha = 0.50, show.legend = FALSE) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Total PV Module Quantity, in comparison to Expected KW/h Production",
       subtitle = "",
       caption = "Visualized by Sarah Stepak")
#`Total Nameplate kW DC` 
plot3 <- ggplot(solar, aes(x=`Total Nameplate kW DC`, y=`Expected KWh Annual Production`)) +
  geom_point(color='blue', alpha = 0.50, show.legend = FALSE) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Total Nameplate kW DC, in comparison to Expected KW/h Production",
       subtitle = "",
       caption = "Visualized by Sarah Stepak")
#`Project Cost`
plot4 <- ggplot(solar, aes(x=`Project Cost`, y=`Expected KWh Annual Production`)) +
  geom_point(color='blue', alpha = 0.50, show.legend = FALSE) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Project Cost, in comparison to Expected KW/h Production",
       subtitle = "",
       caption = "Visualized by Sarah Stepak")
# Plots the graphs side by side using grid
grid.arrange(plot1,plot2,plot3,plot4, ncol=2,padding=1)
rm(plot1,plot2,plot3,plot4)

  
# Modifies plot2 to possibly see any correlation with variables: `Project Cost`
# and `Total Inverter Quantity` .
#
# `Project Cost`
plot1 <- ggplot(solar, aes(x=`Total PV Module Quantity`, y=`Expected KWh Annual Production`)) +
  geom_point(aes(color = `Project Cost`)) +
  labs(title = "Total PV Module Quantity, in comparison to Expected KW/h Production",
       subtitle = "Cross compared with the Total Project Cost",
       caption = "Visualized by Sarah Stepak")
#`Total Inverter Quantity`
plot2 <- ggplot(solar, aes(x=`Total PV Module Quantity`, y=`Expected KWh Annual Production`)) +
  geom_point(aes(color = `$Incentive` )) +
  labs(title = "Total PV Module Quantity, in comparison to Expected KW/h Production",
       subtitle = "Cross compared with Incentive.",
       caption = "Visualized by Sarah Stepak")
# Plots the graphs side by side using grid
grid.arrange(plot1,plot2, ncol=2,padding=1)
rm(plot1,plot2)


# Looks to see if the project is affordable per county. Graphs are visualized
# in a side by side comparison regarding the usage of a bar chart and scatter plot.
#
plot1 <- ggplot(solar, aes(x=County, fill=`Affordable Solar`)) +
  geom_bar() +
  labs(title = "NY County in comparison to Affordability",
       subtitle = "Bar Chart Comparison",
       caption = "Visualized by Sarah Stepak")
plot2 <- ggplot(solar, aes(x=`Project Cost`, y=County)) +
  geom_point(color='red', alpha=0.5, show.legend = FALSE) +
  facet_grid( . ~as.factor(`Affordable Solar`)) +
  labs(title = "NY County's Solar Project Cost in comparison to Affordability",
       subtitle = "Point Comparison",
       caption = "Visualized by Sarah Stepak")
# Plots the graphs side by side using grid
grid.arrange(plot1,plot2, ncol=2,padding=1)
rm(plot1,plot2)

# Looks to see if the project is apart of the green plan through the usage of 
# Bar charts and Point graphs, respectfully. 
#
plot1 <- ggplot(solar, aes(x=County, fill=`Green Jobs Green New York Participant`)) +
  geom_bar() +
  labs(title = "NY County in comparison to NY's Green Jobs Participanty",
       subtitle = "Bar Chart Comparison",
       caption = "Visualized by Sarah Stepak")
plot2 <- ggplot(solar, aes(x=`Project Cost`, y=County)) +
  geom_point(color='red', alpha=0.5, show.legend = FALSE) +
  facet_grid( . ~as.factor(`Green Jobs Green New York Participant`)) +
  labs(title = "NY County's Solar Project Cost in comparison to NY's Green Jobs Participanty",
       subtitle = "Point Comparison",
       caption = "Visualized by Sarah Stepak")
# Plots the graphs side by side using grid
grid.arrange(plot1,plot2, ncol=2,padding=1)
rm(plot1,plot2)


#Creates a violin plot comparing project cost to NY's Green Jobs Participanty, 
# As well as Affordability. 
#
plot1 <- ggplot(solar, aes(x=`Green Jobs Green New York Participant`, y=`Project Cost`)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75), fill="lightblue") +
  labs(title = "NY's Green Jobs Participanty in comparison to Total Project Cost",
       subtitle = "Violin Comparison",
       caption = "Visualized by Sarah Stepak")
plot2 <- ggplot(solar, aes(x=`Affordable Solar`, y=`Project Cost`)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75), fill="orange") +
  labs(title = "NY's Green Jobs Participanty in comparison to Total Project Cost",
       subtitle = "Violin Comparison",
       caption = "Visualized by Sarah Stepak")
# Plots the graphs side by side using grid
#grid.arrange(plot1,plot2, ncol=2,padding=1)
#rm(plot1,plot2,plot3,plot4)
#
# The previous violin plots should be represented better. The following replaces the
# previous two charts with a scatter plot geometry. Places them side by side the 
# previous plots for comparison.
#
# `Green Jobs Green New York Participant`
plot3 <- ggplot(solar, aes(x=`Green Jobs Green New York Participant`, y=`Project Cost`)) +
  geom_point(color='blue', alpha=0.5, show.legend = FALSE) +
  labs(title = "NY's Green Jobs Participanty in comparison to Total Project Cost",
       subtitle = "Scatter-plot Comparison",
       caption = "Visualized by Sarah Stepak")
#`Affordable Solar`
plot4 <- ggplot(solar, aes(x=`Affordable Solar`, y=`Project Cost`)) +
  geom_point(color='blue', alpha=0.5, show.legend = FALSE) +
  labs(title = "Affordability in comparison to Total Project Cost",
       subtitle = "Scatter-plot Comparison",
       caption = "Visualized by Sarah Stepak")
# Plots the graphs side by side using grid
grid.arrange(plot1,plot2,plot3,plot4, ncol=2,padding=1)
rm(plot1,plot2,plot3,plot4)


# Creates a scatter plot comparing variables `Primary Inverter Manufacturer`,
# and `Total Inverter Quantity`.
#
ggplot(solar, aes(x=`Total Inverter Quantity`, y=`Primary Inverter Manufacturer`)) +
  geom_point(color='blue', alpha=0.5, show.legend = FALSE) +
  labs(title = "Total Inverter Quantity to `Primary Inverter Manufacturer`",
       caption = "Visualized by Sarah Stepak")

# Creates a scatter plot comparing variables `Primary Inverter Manufacturer` ,
# and `Project Cost`. Categorizes data by  Project Status
#
ggplot(solar, aes(x=`Project Cost`, y=`Primary Inverter Manufacturer`)) +
  geom_point(aes(color = Status), alpha=0.5, show.legend = FALSE) +
  facet_grid( . ~as.factor(Status)) +
  labs(title = "Project Cost to `Primary Inverter Manufacturer`",
       subtitle = "Catagorized by Project Status",
       caption = "Visualized by Sarah Stepak")


# Creates a scatter plot comparing variables `Primary PV Module Manufacturer` ,
# and `Total PV Module Quantity`
#
ggplot(solar, aes(x=`Total PV Module Quantity`, y=`Primary PV Module Manufacturer`)) +
  geom_point(color='blue', alpha=0.5, show.legend = FALSE) +
  labs(title = "Total PV Module Quantity to `Primary PV Module Manufacturer`",
       caption = "Visualized by Sarah Stepak")


# Creates a scatter plot comparing variables `Primary PV Module Manufacturer` ,
# and `Project Cost`. Categorizes data by  Project Status
#
ggplot(solar, aes(x=`Project Cost`, y=`Primary PV Module Manufacturer`)) +
  geom_point(aes(color = Status), alpha=0.5, show.legend = FALSE) +
  facet_grid( . ~as.factor(Status)) +
  labs(title = "Project Cost to `Primary PV Module Manufacturer`",
       subtitle = "Catagorized by Project Status",
       caption = "Visualized by Sarah Stepak")