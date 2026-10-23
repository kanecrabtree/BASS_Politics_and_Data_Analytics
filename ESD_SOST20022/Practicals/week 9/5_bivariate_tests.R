#                          ############################################                            #
#                          ###    SURVEY DATA ANALYSIS IN R III.    ###                            #
#                          ###       TESTS WITH TWO VARIABLES       ###                            #
#                          ############################################                            #

###
# This script was originally prepared for the undergraduate course titled
# 'Essentials of survey design and analysis' at the University of Manchester
# in the 2020/21 academic year.
#
# The script was prepared by Andras Voros.
# (this is the version of 26.02.2021)
###

###
# This week, we will learn how to perform hypothesis tests about the relation between
# two variables. We will try three tests for different measurement level combinations:
#     1. nominal/ordinal - nominal/ordinal
#     2. nominal/ordinal - continuous
#     3. continuous - continuous
#
# Note: We will assume throughout that the data comes from an SRS, but this will not
#       be true. We do this to simplify the calculations. We will take into account
#       weights at certain points however.
###


### 1. LOAD THE DATA

getwd() # is the current working directory the right one?
# if not, you can set using setwd() - see the previous scripts

# if the working directory is set up correctly:
load("LFSdata.Rdata")


### 2. EXPLORE VARIABLES

# we will use three variables from this dataset:
# TOTHRS  - number of hours respondent worked in the week of the data collection
# AGEEULR - age band of respondent (5-year intervals starting at 15, e.g. 1: 15-19, 2: 20-24, ...)
# SEX     - sex of the respondent (1: male, 2: female)
table(data$AGEEULR)

# a quick look at the distributions
barplot(table(data$AGEEULR), main="Age") # the 12 age bands
barplot(table(data$SEX), main="Sex") # two sexes
hist(data$TOTHRS, main="Work hours per week")


### 3. TESTING THE INDEPENDENCE OF NON-CONTINUOUS VARIABLES

# H0: sex and age are independent
# H1: sex ang age are not independent

# the contingency table
table(data$SEX, data$AGEEULR)

# the Chi-squared test
chisq <- chisq.test(data$SEX, data$AGEEULR)
chisq
# the test statistic is 23.159, with 11 degrees of freedom
# p-value is 0.01679 - probability of getting a more extreme test stat is 1.7%
# lower than 5% -> reject H0, the two variables are related


### 4. TESTING THE DIFFERENCE BETWEEN MEANS

# H0: men and women work the same number of hours on average
# H1: men and women work different amount of hours on average

# the hours worked by men
hours_men <- data$TOTHRS[data$SEX==1]
# the hours worked by women
hours_women <- data$TOTHRS[data$SEX==2]
meanstest <- t.test(hours_men, hours_women)
meanstest
# mean for men: 36.5, mean for women: 26.8
# p-value very close to 0 --> reject H0 - men and women work different number of hours

# note: we can use a t test even when the sample size is large
#       it gets very similar to a normal distribution


### 5. TESTING CORRELATIONS

# H0: hours worked and age are uncorrelated
# H1: hours worked and age are correlated

cortest <- cor.test(data$AGEEULR, data$TOTHRS)
cortest
# correlation is -0.015 (close to 0)
# p-value is 0.08 > 0.05 -> cannot reject H0, we cannot rule out that the variables are uncorrelated

# note: you should use two truly continuous variables for this test; age was ordinal in this case,
#       which is not ideal but it was acceptable for a quick demonstraton
#       (the variable had equal intervals of 5 years, more than 10 categories, and actual age
#       is really continuous)


# you can save your workspace to have it in the future
save.image('LFSdata.RData')


### SECTION SUMMARY

###
# In this section, we learned how to run three types of tests about bivariate relations in R.
###


### END OF SCRIPT - PLEASE OPEN: "exercise3.R"

