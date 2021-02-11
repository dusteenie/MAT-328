# @author Sarah Stepak
# @since  02.09.2021
# @program Lab 4 
# @dataset FAKE_DOG_DATA_new
# Data provided by Dr. S. Hardy.

# Renames the dataset
dogs <- FAKE_DOG_DATA_new

# Prints a summary of the data
summary(dogs)

# Uses ifelse() to create a down.yn var with vals 'yes' and 'no'
# Verifies the result with table()
dogs$down.yn <- ifelse(dogs$down == 0, "No", "Yes")
table(dogs$down, dogs$down.yn, exclude = NULL)

# Uses within() to create an obedience var using training
# Verifies the result with table()
dogs <- within(dogs, {
  obedience <- NA
  obedience [training == 0] <- "None"
  obedience [training == 1] <- "Beginner"
  obedience [training == 2] <- "Intermediate"
  obedience [training == 3] <- "Advanced"
})
table(dogs$training, dogs$obedience, exclude = NULL)

# Uses ordered() to order the obedience var
# Verifies the result with table()
table(dogs$obedience)
temp <- ordered(dogs$obedience, levels=c("None","Beginner","Intermediate","Advanced"))
table(temp, exclude = NULL)
table(dogs$training,temp, exclude = NULL)

dogs$obedience <- temp
rm(temp)

# 6 
# Issue
# Improper output
# Golden Retriever Poodle <NA>
dogs <- within(dogs,{
  dam.breed <- NA
  dam.breed [dam == "gold" || dam == "Gold"] <- "Golden Retriever"
  dam.breed [dam == "lab"] <- "Labrador Retriever"
  dam.breed [dam == "pood"] <- "Poodle"
  
  sire.breed <- NA
  sire.breed [sire == "gold" ] <- "Golden Retriever"
  sire.breed [sire == "lab" || sire == "lag"] <- "Labrador Retriever"
  sire.breed [sire == "pood"] <- "Poodle"
})
table(dogs$dam, dogs$dam.breed, exclude = NULL)
table(dogs$sire, dogs$sire.breed, exclude = NULL)



# 7
# Neex to fix #6 prior 
temp <- ifelse()
rm(temp)

#8 
# Issue
# attempt to make a table with >= 2^31 elements
temp <- within(dogs,{
  size <- NA
  size [dogs$weight < 56] <- "Small"
  size [dogs$weight >= 56 & dogs$weight <= 70] <- "Medium"
  size [dogs$weight > 70] <- "Large"
})
ordered(temp,levels=c("Small","Medium","Large"))
table(temp, exclude = NULL)
rm(temp)

#9
# Issue
# Temp not found
temp <- within(dogs,{
  ster.type < NA
  ster.type [dogs$ster == 0] <- "None"
  ster.type [dogs$ster == 1 & dogs$sex == "M"] <-"Neuter"
  ster.type [dogs$ster == 1 & dogs$sex == "F"] <-"Spay"
  ster.type [dogs$ster == 1 & dogs$sex != "F" & dogs$sex != "M"] <-"Unknown"
})
table(temp, exclude = NULL)
rm(temp)