# @author Sarah Stepak
# @since  02.11.2021
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


# Uses the within() function to create sire.breed and dam.breed
# vars with the full breed names. Verifies using table()
# Accounts for anomalous data entries.
dogs <- within(dogs,{
  dam.breed <- NA
  dam.breed [dam == "gold" | dam == "Gold"] <- "Golden Retriever"
  dam.breed [dam == "lab"] <- "Labrador Retriever"
  dam.breed [dam == "pood"] <- "Poodle"
  
  sire.breed <- NA
  sire.breed [sire == "gold" ] <- "Golden Retriever"
  sire.breed [sire == "lab" | sire == "lag"] <- "Labrador Retriever"
  sire.breed [sire == "pood"] <- "Poodle"
})
table(dogs$dam, dogs$dam.breed, exclude = NULL)
table(dogs$sire, dogs$sire.breed, exclude = NULL)


# Uses ifelse()to create breed var containing values of both
# sire and dam breeds, “Mixed” otherwise.
# Verifies using table().
# Note usage : ifelse(test, yes, no)
temp <- ifelse(dogs$sire.breed == dogs$dam.breed, dogs$dam.breed,"Mixed")
temp <- ordered(temp,levels=c("Golden Retriever","Labrador Retriever","Poodle", "Mixed"))
table(temp, exclude = NULL)
dogs$breed <- temp
rm(temp)


# Uses within() to create var size with the values “Small” (if weight is less than 56), 
# “Medium” (if weight is between 56 and 70 inclusive), and 
# “Large” (if weight is over 70). Uses ordered() to create an ordered variable. 
# Verifies with table()
temp <- within(dogs,{
  size <- NA
  size [weight < 56] <- "Small"
  size [weight >= 56 & weight <= 70] <- "Medium"
  size [weight > 70] <- "Large"
})
temp$size <- ordered(temp$size,levels=c("Small","Medium","Large")) 
table(temp$size, exclude = NULL)
rm(temp)


# Uses within() function to create, based on the ster variable, 
# var type with“None” (if unsterilized), “Neuter” (if sterilized and male),
# ”Spay” (if sterilized and female), or “Unknown.”
# Verifies with table()
temp <- within(dogs,{
  type <- NA
  type [ster == 0] <-"None"
  type [ster == 1 & sex == "M"] <-"Neuter"
  type [ster == 1 & sex == "F"] <-"Spay"
  type [ster == 1 & sex != "F" & sex != "M"] <-"Unknown"
})
temp$type <- ordered(temp$type,levels=c("None","Neuter","Spay","Unknown"))
table(dogs$ster, temp$type, exclude = NULL)
table(dogs$sex, temp$type, exclude = NULL)
rm(temp)