# @author Sarah Stepak
# @since  02.04.2021
# @program Lab 3 (R Basics continued) 
#          Finding and fixing errors
# Data provided by Dr. S. Hardy.


# ANSWERS ARE IN FORMAT:

# #Wrong line of code
# right line of code


#subset(Credit, Balance = 0)
subset(Credit, Balance == 0)

#subset(Credit, cards > 5)
subset(Credit, Cards > 5)

#subset(Credit, Rating !< 400)
subset(Credit, Rating < 400)

#subset(Credit, Gender == "male")
subset(Credit, Gender == "Male")

#subset(Credit, Student == No )
subset(Credit, Student == "No" )

#subset(Credit, Cards =! 1 )
subset(Credit, Cards != 1 )

#subset(Credit, !is.NA(Gender) )
subset(Credit, !is.na(Gender) )

#subset(Credit, is.na(Gender)
subset(Credit, is.na(Gender))

#subset(Credit, Educ==7 & Educ==8 )
subset(Credit, Educ==7 | Educ ==8)

#subset(Credit, 300 <= Rating < 500)
subset(Credit, Rating >= 300 & Rating < 500)

#subset(Credit, Income <= "50000")
subset(Credit, Income <= 50000)

#subset(Credit, Limit < 5000, select=(Income,Limit))
subset(Credit, Limit < 5000, select=c(Income,Limit))

#subset(Credit, Limit < 5000, Balance >= 4000)
subset(Credit, Limit < 5000 & Balance >= 4000)

#subset(Credit, Cards = 2:4)
subset(Credit, Cards == 2 | Cards == 3 | Cards == 4)

#subset(Credit, !duplicated(Male))
subset(Credit, !duplicated(Gender))

#subset(Credit, Limit < 5000, select==c(Limit,Balance))
subset(Credit, Limit < 5000, select=c(Limit,Balance))

#subset(Credit, Student | !Married)
subset(Credit, Student == "Yes" | Married == "No")