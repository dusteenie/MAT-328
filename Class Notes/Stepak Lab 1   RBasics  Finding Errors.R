# @author Sarah Stepak
# @since  01.28.2021
# The dataset is msleep, we are finding errors
# Data provided by Dr. S. Hardy.


# Shows us the dataset
names(msleep_msleep)
dim(msleep_msleep)


msleep_msleep -> msleep
#Renames the data file to just msleep

table(msleep_msleep$brainwt)
#Error: Misspell

table(Msleep$order)
Table(msleep$genus)
#Case Sensistive - Should not be cap.

table(msleep_msleep$vore,exclude=NULL)
#should be exclude not exclide

table(msleep$vore,exclude="NULL")
#Null should not be in quotes

table(msleep$vore,,exclude=NULL)
#Two commas, should only be one

table(msleep_msleep$awake,exclude=NULL)#this one works, but is not something you want to do, why not
# Should exclude nulls, better way to format this rather than tables

tabout <- table(msleep_msleep$vore,msleep_msleep$conservation) #this line is ok
prop.table(tabout, margin=3)
#Have to include exclude null, margin has to be one or two

round(prop.table(tabout, margin=1,2))
#Two is an unused argument, Have to exclude nulls,the parens should go =1),2)

round(prop.table(tabout, margin=1),2))
# Too many parens

aggregate(vore~awake,data=msleep_msleep,median)
#Variables should be switched around (vore and awake) Also there are NANS

aggregate(awake~vore+conservation,median)
#Missing ,data=msleep ext. 

aggregate(awake=vore+conservation,data=msleep, median)
# equal sign should be squiggle

aggregate(awake~vore+bodywt,data=msleep,median)
#Bodyweight is a numeric, it will run but we'll just get a really big table
#We want to clear this up


