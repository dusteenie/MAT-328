# @author Sarah Stepak
# @since  02.05.2021
# @program Lab 2
# @dataset msleep
# Data provided by Dr. S. Hardy

# Renames the dataset
#
msleep <- msleep_msleep


#Creates a table for the following: vore, order, conservation, 
# order AND vore, order AND conservation
#
table(msleep$vore, exclude=NULL)
table(msleep$order, exclude=NULL)
table(msleep$conservation, exclude=NULL)
table(msleep$order, msleep$vore, exclude=NULL)
table(msleep$order, msleep$conservation, exclude=NULL)


#Finds the row and column proportions of order && vore table
#
order_vore_table <- table(msleep$order, msleep$vore, exclude=NULL)
prop.table(order_vore_table) # Not rounded, margin = 0
round(prop.table(order_vore_table),2) #rounded, margin = 0
prop.table(order_vore_table, margin=1) # Not rounded, margin = 1
round(prop.table(order_vore_table, margin=1),2) #rounded, margin = 1
prop.table(order_vore_table, margin=2) # Not rounded, margin = 2
round(prop.table(order_vore_table, margin=2),2) #rounded, margin = 2


#Finds the mean sleep_rem by vore
#
vore <- msleep$vore
sleep_rem <- msleep$sleep_rem
df <- data.frame(sleep_rem, vore)
aggregate(sleep_rem~vore,data=df,FUN=mean)



#Finds the median sleep_total by order
#
order <- msleep$order
sleep_total <- msleep$sleep_total
df <- data.frame(sleep_total, order)
aggregate(sleep_total~order,data=df,FUN=median)