# @author Dusty Stepak
# @since  02.11.2021
# @program Lab 5 
# @dataset STUDENT_EXTRACT_328_SWH_9817
# Data provided by Dr. S. Hardy.

# Renames the data file to Student
student <-  STUDENT_EXTRACT_328_SWH_9817

summary(student)

help(names)

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
temp <- within(student$Term.type, {
  Semester <- NA
  Semester [student$Term.type == 1 ] <- 'Fall'
  Semester [student$Term.type == 2 ] <- 'Spring'
  Semester [student$Term.type == 3 ] <- 'May' 
})
table(temp, exclude = NULL)