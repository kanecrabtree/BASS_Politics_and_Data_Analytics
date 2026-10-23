#                          ############################################                            #
#                          ###     SURVEY DATA ANALYSIS IN R II.    ###                            #
#                          ###    CONFIDENCE INTERVALS AND TESTS    ###                            #
#                          ############################################                            #

###
# This script was originally prepared for the undergraduate course titled
# 'Essentials of survey design and analysis' at the University of Manchester
# in the 2020/21 academic year.
#
# The script was prepared by Andras Voros.
# (this is the version of 25.02.2021)
###

###
# We continue our work on the Labour Force Survey (LFS) data. This script shows how to 
# calculate a confidence interval and how to perform a hypothesis test in R.
# (We assume that the data comes from an SRS.)
###


### 1. LOADING THE DATA

# as always, we start by making sure the R working directory is set to the folder containing
# the data and scripts for this week.

getwd() # is the current working directory the right one?
# if not, you can set using setwd() - see the previous scripts

# if you close R after finishing the previous script, you should load the data again:
load("LFSdata.RData")
# you should see the data and some sample statistic objects in your workspace


### 3. CONFIDENCE INTERVAL

# let's calculate the 95% confidence interval for the population mean hours worked

# remember that the CI = mean +/- critical value * s.e
tothrs_mean # this is the mean
tothrs_se   # this is the s.e.

# how do we get the critical value for the 95% confidence level?
# luckily, it's quite easy:
cv95 <- qnorm(0.975)
# note: we will learn next week why 0.975 is used here 

# the lower and upper bounds of the CI
tothrs_CI_lower <- tothrs_mean - cv95 * tothrs_se
tothrs_CI_upper <- tothrs_mean + cv95 * tothrs_se

tothrs_CI_lower
tothrs_CI_upper

# MINITASK: How do you interpret the results?
#           Do you think the uncertainty of our estimate for the average work hours
#           is large or small?


### 4. HYPOTHESIS TEST

# let's test if the average work hours per week in the population equals 35 hours

## a. the hypotheses
# H0: mu = 35
# H1: mu != 35 (!= means "not equal" in R's language)

## b. the sample statistic and s.e.
tothrs_mean
tothrs_se

## c. the test statistic
# (mean - mu) / s.e.
test35 <- (tothrs_mean - 35) / tothrs_se
test35

## d. compare test statistic against null-distribution
test35 < -cv95 # the test statistic is negative, so we compare with -1.96
# test statistic is smaller

## e. decision
# we reject H0 -> the average hours worked per week is not 35

# this had quite a few steps... could we do it more easily?
# YES!
# we will learn about a simple test function next week


# this is the end of the script, you can save your workspace to have it for next week
save.image('LFSdata.RData')

### SECTION SUMMARY

###
# In this section, we calculated confidence intervals and test statistics by hand. Next week,
# we will look different types of hypothesis tests and R functions that carry out the calculations
# for us.
###


### END OF SCRIPT - PLEASE OPEN: "exercise2.R"