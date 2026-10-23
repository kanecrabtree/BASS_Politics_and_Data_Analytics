#                       ##############################################                             #
#                       ###         INDIVIDUAL EXERCISE 3          ###                             #
#                       ###       TESTS WITH TWO VARIABLES         ###                             #
#                       ##############################################                             #

###
# The script was prepared by Andras Voros.
# (this is the version of 25.02.2021)
###

### OVERVIEW
# The aim of the exercise is to practice the three bivariate tests covered in 
# the previous script.
#
# DATA. You can use any social survey dataset that you can find for this analysis.
# The dataset has to contain two nominal and two continuous variables.
#
# SET THE TASK BASED ON YOUR R SKILL LEVEL. Try to make the most of this exercise by
# choosing the data to work with according to your R knowledge:
#   a. REPLICATION: use the LFS survey data from the previous exercise - this is suggested
#                   if you are an R beginner; try to rewrite the analysis from the previous
#                   script; you can look at the script if you are stuck
#   b. EXTENSION: use the Scots Miners data from week 2 - this is suggested when you feel
#                 uncertain about reading and recoding data in R; extend the analyses from
#                 week 2 with a few statistical tests; you will have the data prepared and
#                 you will only need to focus on getting the analysis right
#   c. INDEPENDENT STUDY: use any appropriate survey data - this is suggested for those who
#                 want to practice reading, recoding, and analysing data at once; you can
#                 look at earlier scripts for ideas but you will have to adapt them for your
#                 dataset
# NOTE: you can also decide to do all three of the above, maybe not at the same time but
#       throughout the rest of the semester; this is good practice and version c. above is
#       basically the analysis you need to do for your final report - so it's worth it!
#
# HOW TO PROCEED. Below you can find the list of instructions for the exercise. This time
#                 you won't get much help here. However, you can use the earlier scripts 
#                 in the course, which should have the answer for everything needed in this
#                 exercise.
#
###


### INSTRUCTIONS
# 1. Look for an interesting dataset in the UK Data Service's archive or a different repository
#    (alternatively: use the LSF data or the Scots Miners data - see the description above)
# 2. Download the data and read it in R.
# 3. Select two nominal/ordinal and two continuous variables from the dataset. You can assume
#     that the data comes from an SRS and is unweighted (even if weights are available).
# 4. Select two nominal/ordinal variables and test their independence with chisq.test().
# 5. Select a continuous variable and test if it has the same mean in two categories of a
#     a nominal/ordinal variable with t.test().
# 6. Select two continues variables and test if their correlation is zero with cor.test().
#
# Note: you can assume in this exercise that the data were drawn using SRS.
###


### START OF INDIVIDUAL PRACTICE

# check your working directory and change it if it's not set to where the data is!
getwd()
#setwd()


## 1. Look for a dataset

# you don't need R for this
# try here: https://www.ukdataservice.ac.uk/get-data
# or use any other data archive


## 2. Download the data and read it into R




## 3. Select two nominal/ordinal and two continuous variables from the dataset




## 4. Select two nominal/ordinal variables and test their independence - chisq.test()




# 5. Select a continuous variable and test if it has the same mean in two categories of a
#     a nominal/ordinal variable - t.test()




## 6. Select two continues variables and test if their correlation is zero - cor.test()




# Save your workspace before you close R
save.image("MyData.RData")
# and remove all of the objects
rm(list=ls())


###
# Note that your work in this exercise can be used directly when preparing the analysis
# for your final report.
###

### END OF SCRIPT