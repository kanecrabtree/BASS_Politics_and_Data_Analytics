#                       ##############################################                             #
#                       ###         INDIVIDUAL EXERCISE 1          ###                             #
#                       ###       MEAN AND STANDARD DEVIATION      ###                             #
#                       ##############################################                             #

###
# The script was prepared by Andras Voros.
# (this is the version of 13.02.2021)
###

### OVERVIEW
# The aim of the exercise is to practice the basic R we have talked through so far.
# It is not a test, so take your time and concentrate on how each function works. 
# Whether you use the earlier srcipts or not is your choice. If you are stuck 
# somewhere, or something doesn't work, just ask questions through the usual channels.
#
# DATA. You will use the subset of the Scots Miners 1891 Census Survey dataset introduced
# earlier. Information about the data and see the UK Data Service's archive:
# https://beta.ukdataservice.ac.uk/datacatalogue/studies/study?id=3651#!/details
#
# HOW TO PROCEED. Below you can find the list of instructions for the exercise.
# After that comes a partially written script - you need to fill in the blanks,
# but there will be enough help that you won't get lost. This is all. Go on.
###


### INSTRUCTIONS
# 1. Read the dataset (again) from the original csv file.
# 2. Create two (vector) objects containing the data about miners'
#             a. age
#             b. marital status
# 3. Recode the marital status object into a "married vs. single" variable,
#    following these recoding instructions:
#             m ->  1 (married)
#             s ->  0 (single)
#             w -> NA (widowed)
#             o -> NA (data not available)
# 4. Calculate the average age and the standard deviation of age in the dataset.
#    Interpret the results.
# 5. Calculate the proportion of married miners and the standard deviation of the
#    recoded married object. Interpret the results.
# +. Create a histogram for the age distribution.
###


### START OF INDIVIDUAL PRACTICE

# check your working directory and change it if it's not set to where the data is!
getwd()
#setwd()

library(psych)
library(dplyr)
library(lattice)
library(ggplot2)
library(tidyr)
library(janitor)

rm(list=ls())
# 1. Read data

# This is copied here from the previous script
data <- read.table("miners_data.csv", header = TRUE, sep=",", stringsAsFactors = FALSE)


# 2. Create age and marital status objects.

# first, you can use the  colnames() function to see which columns contain the data
colnames(data) # we are interested in "Age" and "Marstat"

# now define the two vector objects - we have seen two ways for doing this
# (one involved [] and the other $)
age <- data$Age # the question marks are placeholders for your code
marital.status <- data$Marstat


# 3. Recode the maritalMarstat# 3. Recode the marital status object

# here is the recoding scheme again:
#             m ->  1 (married)
#             s ->  0 (single)
#             w -> NA (widowed)
#             o -> NA (data not available)

# let's first create a new object for the result
married <- marital.status
tabyl(married)

# now we can do the recoding for this object
married[married=="m"] <- 1
married[married=="s"] <- 0
married[married=="w"] <- NA
married[married=="o"] <- NA

# there is only one small problem
married[1:20] # cell values have "" around them
mode(married) # because the mode of the object is still character
# you can make the married objec numeric like this
married <- as.numeric(married)
married[1:20] # now it looks better


# 4. Calculate and interpret the average and s.d. for age

# please study the R help pages for the following functions
?mean
?sd

# and now calculate the mean and s.d.
age.mean <- mean(age)
age.sd <- sd(age)

# give a brief interpretation of the mean() and sd() functions


# 5. Calculate average and s.d. for married

# watch out, this variable has missing data
married.mean <- mean(married, na.rm=T)
married.sd <- sd(married, na.rm = T)


# +. Create a histogram of age

# study the R help page of the hist() function
?hist

# plot a histogram
hist(age)


# Finally, save your workspace, because the dataset may be useful in later classes.
save.image("MinersData.RData")
# and remove all of the objects
rm(list=ls())


###
# Note that while completing this assigment you have written a script that
# does basic transformations and a quick description of the data for you - 
# this can be used and adapted easily for other datasets.
###

### END OF SCRIPT