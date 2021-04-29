# @author Sarah Stepak
# @since  02.22.2021
# @program Lab 5 
# @dataset STUDENT_EXTRACT_328_SWH_9817
# Data provided by Dr. S. Hardy.

# Renames the data file to student
student <-  STUDENT_EXTRACT_328_SWH_9817

# Checks the dimension, names and structure of student
summary(student)
dim(student)
names(student)

# Creates new names that replace blank spaces in the names with “.” using 
#  the gsub() function. Then replace the original names with the new names.
names(student) <- gsub(" ", ".",names(student))
summary(student)

# Use the substring() function to create a Term.Type variable using 
# the MaineStreet Term variable where the third character indicates the term.
temp <- substring(student$Term, 3,3)
student$Term.type <- temp
table(student$Term.type)
rm(temp)

# Use the within() function and the Term.Type variable created above to create a
# Semester variable, Term.Type “1”is for Fall, “2” for Spring, and “3” for May.
temp <- within(student, {
  Semester <- NA
  Semester [Term.type == 1 ] <- 'Fall'
  Semester [Term.type == 2 ] <- 'Spring'
  Semester [Term.type == 3 ] <- 'May' 
})
table(temp$Semester, exclude = NULL)
student$Semester <- temp$Semester
rm(temp)

# Uses ordered() on var Semester.
# Makes a table of semesters as well.
student$Semester <- ordered(student$Semester, levels = c("Fall", "Spring", "May"))
table(student$Semester, exclude = NULL)

# Creates a df called unique.plan which contains
# only the first occurrence of Acad.Plan. Orders and views it.
unique.plan <- subset(student, !duplicated(student$Acad.Plan), select=c(5:6))
unique.plan <- unique.plan[order(unique.plan$Acad.Plan),]
View(unique.plan)

# Creates a subset named 'temp' that excludes the non-degree students
# as well as the May and Summer terms. Checks values by making tables
# of academic plans and terms. Copies temp into student upon success.
#
# Ask - < table of extent 0 >
temp <- subset(student, Term != "May" & Term != "Summer" & Plan.Type != "PRP")
table(temp$Acad.Plan, exclude = NULL)
table(temp$Term , exclude = NULL)
table(temp$Term.type, exclude = NULL)
student <- temp
rm(temp)

# Finds the total number of FA.Taken per Term  using aggregate()
# (in MaineStreet FA.Taken is the number of credits
creditByTerm <- aggregate(student$FA.Taken ~ student$Term, data=student, sum)

# Finds the mean of FA.Taken per combinations of Semester and 
# Tuition.Resid. Uses aggregate(). 
temp <- aggregate(FA.Taken~Semester + Tuition.Resid, data = student, mean)
table(temp)
rm(temp)

# Creates var Full.Part with val "Full" if a student is taking
# 12 or more credits, "Part" otherwise
student$Full.Part <- ifelse(student$FA.Taken >= 12, "Full", "Part")
table(student$Full.Part, exclude = NULL)

# Creates var Gender with categories "Male" "Female" and "Unknown."
#
# Issue with temp var, upon resolution I will merge with student
temp <- within(student,{
  Gender <- NA
  Gender [Sex == "M"] <- "Male"
  Gender [Sex == "F"] <- "Female"
  Gender [Sex != "M" & Sex != "F"] <- "Unknown"
}) 
student <- temp
rm(temp)

# Makes a table comparing Acad.Prog and Gender
table(student$Acad.Prog, student$Gender, exclude = NULL)

# Finds the % of Gender for each Acad.Prog using prop.table(). 
# Rounded to one decimal
percentage <- table(student$Acad.Prog, student$Gender)
round(prop.table(percentage),1)

# Creates a table of admission terms
temp <- subset(student,!duplicated(student$FAKEID),select = c(1:14))
table(temp$Admit.Term)