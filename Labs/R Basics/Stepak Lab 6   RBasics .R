# @author Sarah Stepak
# @since  02.18.2021
# @program Lab 6 
# @dataset IFW_Kills and maine_pop_by_city
# Data provided by Dr. S. Hardy.

# Imports the datasets
ifw <- IFW_Kills_test
citypop <- maine_pop_by_city

# Checks the dimension and the names for each data set.
dim(ifw)
names(ifw)
#
dim(citypop)
names(citypop)

# Identifies matching column names using intersect()
intersect(names(ifw),names(citypop))

# Finds all unique values for each city col in each subset
# unique(c(ifw$city,citypop$city))
unique(ifw$city)
unique(citypop$city)

# Sorts the unique city values in the ifw data
sort(unique(ifw$city))[1:50] 


#table(sort(ifw$city, decreasing = FALSE), exclude = NULL)

# Standardizes the formatting of city in the ifw data set. 
# Then check the length of the vector again.
temp <- toupper(ifw$city)
temp <- gsub(" ", ".",temp)
#temp
length((ifw$city))
length((temp))
ifw$city <- temp
rm(temp)
temp <- toupper(citypop$city)
temp <- gsub(" ", ".",temp)
#temp
#length((citypop$city))
#length((temp))
citypop$city <- temp
rm(temp)


ifw$count<- 1
ag.city.species <- aggregate(count ~ Species+city, data= ifw ,FUN = sum)
head(ag.city.species)


# Finds the dimension of ag.city.species. Looks at the first five rows after.
dim(ag.city.species)
head(ag.city.species)

# Finds the total value of cities that appear in ifw that do not appear in 
# citypop and vice versa.
length(ifw$city)
length(citypop$city)
interaction(ifw$city,citypop$city)
length(setdiff(ifw$city,citypop$city))
length(setdiff(citypop$city,ifw$city))

# Merges ifw and citypop into pop.species.mer (only with matching vales)
# Checks the dimension using view() on completion
pop.species.mer = merge(ifw, citypop, all.x=FALSE, all.y = FALSE)
View(pop.species.mer)

# Plots population vs total hunt harvest for DEER, BEAR, MOOSE, and TUKF 
plot(count~pop,data=subset(pop.species.mer,Species=="DEER"),main = "Deer")
plot(count~pop,data=subset(pop.species.mer,Species=="BEAR"),main = "Bear")
plot(count~pop,data=subset(pop.species.mer,Species=="MOOSE"),main = "Moose")
plot(count~pop,data=subset(pop.species.mer,Species=="TUKF"),main = "Tukf")
