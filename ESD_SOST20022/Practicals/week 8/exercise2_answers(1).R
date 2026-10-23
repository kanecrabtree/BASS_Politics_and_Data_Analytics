#                       ##############################################                             #
#                       ###         INDIVIDUAL EXERCISE 2          ###                             #
#                       ###      CIs AND TESTS WITH WEIGHTS        ###                             #
#                       ##############################################                             #

###
# The script was prepared by Andras Voros.
# (this is the version of 25.02.2021)
###

### OVERVIEW
# The aim of the exercise is to practice the calculation of confidence intervals
# and test statistics. It will be the same as earlier, with one twist: you should
# take into account the sampling weights in the dataset. You will get hints below
# on how to do this, and we will discuss the solution in the live practical session.
# If you are stuck somewhere, or something doesn't work, just ask questions through 
# the usual channels.
#
# DATA. You will use the subset of the Labour Force Survey dataset introduced
# earlier. Information about the data and see the UK Data Service's archive:
# https://beta.ukdataservice.ac.uk/datacatalogue/studies/study?id=7912#!/details
#
# HOW TO PROCEED. Below you can find the list of instructions for the exercise.
# After that comes a partially written script - you need to fill in the blanks,
# but there will be enough help that you won't get lost. Please start.
###


### INSTRUCTIONS
# 1. Load the dataset from the earlier saved version: LFSdata.RData
# 2. Explore the weighting variable PWT14R in the dataset
# 3. Calculate the mean and standard error, taking into account the sampling weights
# 4. Calculate the confidence interval using the weights
# 5. Test on the weighted data whether the average work hours per week is 35.
# 6. Compare the results with those from the unweighted data. Is the impact of weighting large?
###


### START OF INDIVIDUAL PRACTICE

# check your working directory and change it if it's not set to where the data is!
getwd()
#setwd()

## 1. Load data

# if the working directory is set up correctly:
load("LFSdata.Rdata")


## 2. Explore sampling weights

# this is the variable
head(data$PWT14R)

# let's save it in an object
weights <- data$PWT14R

# its distribution
hist(weights)

# its mean and extreme values
mean(weights)
min(weights)
max(weights)
summary(weights, na.rm = TRUE)


## 3. Calculate mean and s.e. using weights

# a) the mean
tothrs_mean_weighted <- weighted.mean(data$TOTHRS, weights, na.rm=TRUE)
# Alternative Method
weighted.mean_TOTHRS <- weighted.mean(data$TOTHRS, data$PWT14R, na.rm=TRUE)

# b) the standard error: sd/sqrt(n)

# this requires a little calculation...
# first, we need to calculate a new total valid n for the TOTHRS variables, using the weights
tothrs_n_weighted <- sum(weights[is.na(data$TOTHRS)==FALSE]) # don't count weights of missings
# next, we calculate the weighted variance
tothrs_var_weighted <- sum(weights*(data$TOTHRS - tothrs_mean_weighted)^2/tothrs_n_weighted, na.rm=TRUE)
# then, the weighted standard error
tothrs_sd_weighted <- sqrt(tothrs_var_weighted)
# and lastly, the weighted s.e.
tothrs_se_weighted <- tothrs_sd_weighted / sqrt(tothrs_n_weighted)

# a much simpler solution:
# alternatively, you can install and use the weighted.sd() function in the radiant.data package
install.packages("radiant.data") # install package (takes a while)
library(radiant.data) # load package (need to do this every time you start R)
weighted.sd(data$TOTHRS, data$PWT14R, na.rm=T) # it gives the same result as the above


## 4. Calculate CI using weights

# this is simple from here - the same as earlier, only using the weighted statistics

# remember that the CI = mean +/- critical value * s.e
tothrs_mean_weighted # this is the mean
tothrs_se_weighted   # this is the s.e.

# critical value for 95% confidence
cv95

# the lower and upper bounds of the CI
tothrs_CI_lower_weighted <- tothrs_mean_weighted - cv95 * tothrs_se_weighted
tothrs_CI_upper_weighted <- tothrs_mean_weighted + cv95 * tothrs_se_weighted

tothrs_CI_lower_weighted
tothrs_CI_upper_weighted


## 5. Test using weights

# this is also the same as earlier, but with the weighted statistics

# let's test if the average work hours per week in the population equals 35 hours

## a. the hypotheses
# H0: mu = 35
# H1: mu != 35 (!= means "not equal" in R's language)

## b. the sample statistic and s.e.
tothrs_mean_weighted
tothrs_se_weighted

## c. the test statistic
# (mean - mu) / s.e.
test35_weighted <- (tothrs_mean_weighted - 35) / tothrs_se_weighted
test35_weighted

## d. compare test statistic against null-distribution
test35_weighted < -cv95 # the test statistic is negative, so we compare with -1.96
# test statistic is smaller


## e. decision
# we reject H0 -> the average hours worked per week is not 35

# //////////////////////////////					//////////////////////////////
# /////////////////////////							  /////////////////////////
# ////////////////////									       ////////////////////
# ///////////////												         ///////////////
# //////////															        //////////
# /////			     	      ## Alternative Method			             /////
# //////////															        //////////
# ///////////////												         ///////////////
# ////////////////////									       ////////////////////
# /////////////////////////							  /////////////////////////
# //////////////////////////////					//////////////////////////////

t.test(data$TOTHRS, mu = 35, conf.level = 0.95, data = data) #simple t-test

install.packages("weights") #install the package if you don't have it.
library(weights)
wtd.t.test(x = data$TOTHRS, y = 35, weight = data$PWT14R) #weighted t-test


## 6. Compare unweighted and weighted results

# The differences are actually quite minor, the tests have the same conclusion (mean is not 35)


# Finally, save your workspace, because the dataset may be useful in later classes.
save.image("LFSdata.RData")
# and remove all of the objects
rm(list=ls())


###
# Note that you can use what you have written here to calculate statistics and CIs, and
# to test hyoptheses using weighted data.
###

### END OF SCRIPT