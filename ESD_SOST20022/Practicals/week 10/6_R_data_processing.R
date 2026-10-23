#                          ############################################                            #
#                          ###     SURVEY DATA ANALYSIS IN R IV.    ###                            #
#                          ###            DATA PROCESSING           ###                            #
#                          ############################################                            #

###
# This script was originally prepared for the undergraduate course titled
# 'Essentials of survey design and analysis' at the University of Manchester
# in the 2020/21 academic year.
#
# The script was prepared by Andras Voros.
# (this is the version of 03.04.2021)
###

###
# This week, we learn about the basic steps of data processing in R. This is not 
# an exhaustive treatment of the topic. Every dataset is different and so the data
# processing steps required will vary from survey to survey. However, there are a few
# steps that we almost always need to carry out before we can do our analyses:
#       1. data cleaning
#       2. recoding
#       3. handling of outliers
#       4. presenting distributions of variables
# We look at a few examples for these steps here.
#
# Note: The aim of data processing is to understand any problems with the dataset and
#       prepare the data for analysis. We do not want to use the data for inference at
#       this point. Because of this, we can ignore what kind of sampling strategy was
#       used to collect the data - this does not matter for sample description. We could
#       take into account weights, but we will ignore them in this exercise for simplicity.
###


### 0. LOAD THE DATA

getwd() # is the current working directory the right one?
# if not, you can set using setwd() - see the previous scripts

# THE DATASET. We will use the same dataset as in weeks 4 and 5 of the course: 
# the Quarterly Labor Force Survey, January-March 2015 (teaching dataset).
# 
# If you want to refresh your memory about this survey and the available data, look at the
# R script from week 4 titled '3_R_sample_statistics.R' or check here:
# https://beta.ukdataservice.ac.uk/datacatalogue/studies/study?id=7912#!/details
#
# I have created a slightly modified version of this dataset for this exercise.
# The file containing this is called 'LSFdata_modified.RData'.

# if your working directory is set up correctly, this should load the dataset
load("LFSdata_modified.Rdata")

# THE VARIABLES. As before, we will use these three variables from the dataset:
# TOTHRS  - number of hours respondent worked in the week of the data collection
# AGEEULR - age band of respondent (5-year intervals starting at 15, e.g. 1: 15-19, 2: 20-24, ...)
# SEX     - sex of the respondent (1: male, 2: female)

# Note: One of the scripts from week 2, '2_R_RealData.R' discusses different options for opening
#       other types of data files, such as .dat or .xls files.


### 1. DATA CLEANING

# The first step in data processing aims at identifying any obvious erros that
# were made during the data collection or data recording steps. What we are able 
# to check is whether the variables in our dataset have valid values.

# let's see the values gender variable
table(data$SEX)
# this only has values of 1 and 2, which seems OK

# how about the age groups?
table(data$AGEEULR)
# something is not right - why is there 1 occurrence of the letter 'i'?
# this seems like a classic recording error: the 'i' key is close to '8' and '9'
# on the keyboard and if the data was recorded by hand, the person entering the
# data in the computer may have made a mistake

# note that this affects the mode of the variable vector in R
mode(data$AGEEULR) # it's a character vector!
# this will make any meaningful calculation impossible, such as:
mean(data$AGEEULR) # this gives NA because adding a character to a number is not defined in R

# we should fix this error by recoding the 'i' to NA (missing value)
# (we should use NA as we don't know what the real value was)
data$AGEEULR[data$AGEEULR=='i'] <- NA
# and manually change the mode of the variable object to 'numeric'
data$AGEEULR <- as.numeric(data$AGEEULR)
# now we can work with this variable easily
mean(data$AGEEULR, na.rm=T) # note that we need to use na.rm=T ("remove NAs from the calculation")
                            # because we introduced an NA in the recoding

# lastly, how could we check whether the continuous work hours variable is coded correctly?
summary(data$TOTHRS)
# the summary function presents some statistics of the distribution of values,
# such as the minimum, quartiles, median, and maximum
# here we see that the higher values seem OK, but there are many -9s
# these are missing codes, which we should change or 'recode' to NAs - this is the next step


### 2. RECODING

# There are two general reasons why we recode the data before the analysis:
# a. to treat missing values
# b. to create a coding which is adequate for our analysis

# a. treating missing values

# we saw that missings are coded as -9 in the dataset
sum(data==-9, na.rm=T) # there are 21604 missing entries across all 14 variables
sum(is.na(data))       # and there is one lonely NA, which we added earlier
# let's recode all -9 entries to NAs
data[data==-9] <- NA
# it was easy!
sum(is.na(data)) # now there are 21605 NAs (21604 from this step and 1 from our earlier cleaning)
sum(data==-9, na.rm=T) # and 0 -9 values are left, that is great

# (note: after this step, we could decide to impute some or all of the missing values
#        with one of the methods discussed in the lecture)

# b. recoding data for a specific analysis

# you remember that the sex variable has values 1 and 2
table(data$SEX)
# let's assume that you want to perform an analysis that requires 0 and 1 values
# (for example, this can be a linear regression model - not covered in this course)
# we need to recode 1->0 and 2->1, in this order so that we don't ruin the data!
data$SEX[data$SEX==1] <- 0 # recode 1s to 0s
data$SEX[data$SEX==2] <- 1 # recode 2s to 1s
# the result:
table(data$SEX) # is OK

# a similar step is necessary in cases when we have a variable with character value
# labels - we might need to recode these to numbers (e.g. professions to numeric categories)

# note: so far we have recoded the data in the same R objects, basically overwriting the
# original dataset.
# it is sometimes more useful to create new objects for storing recoded variables
# this can be done for example in two steps by
data$SEX_original <- data$SEX # create new variable vector in data
data$SEX_original[data$SEX_original==1] <- 2 # recode 1s to 2s
data$SEX_original[data$SEX_original==0] <- 1 # recode 0s to 1s
# now we have both the original and the recoded versions of the sex variable
table(data$SEX_original)
table(data$SEX)
# in any case, since you have the original data, you can always make modifications to your
# script and run it again in an instant - this is why scripts are so useful!


### 3. HANDLING OUTLIERS

# outliers are observations of a variable which are quite different from most values
# in case of a continuous variable, an outlier is much larger or smaller than the rest
# of the values
# outliers can have a large impact on analysis, for example, they can bias estimates
# (e.g. consider what is the mean of the numbers 1,3,5,7 and the numbers 1,3,5,7,100)

# after recoding the missings, let's look the hours worked in the past week variable
summary(data$TOTHRS)
# the lower and middle part of the distribution seems quite orderly, but the higher values
# are a bit werid: the median is 37 but the maximum is 97 - that is a lot of hours to work
# in a single week!
# we sholud examine how many such outliers we have by looking at the distribution
hist(data$TOTHRS)
# a few people report working 70+ hours in the week before the data collection
# we can look at the frequency of these high values
table(data$TOTHRS[data$TOTHRS>70]) # they are quite rare relative to the 20,000 observations
                                   # but they can have a huge impact on estimates

# it's up to us to decide what to do with these outliers
# they may be valid data but they may be mesurement or processing error

# for the sake of the example, let's assume that values larger than 90 are by mistake
# and let's recode these to NA
data$TOTHRS[data$TOTHRS>90] <- NA

# you could make further assumptions and recode other values, but:
# WARNING! You should generally be very careful with handling outliers; the safest option is
# to note their presence and leave them alone unless you know they are the result of some error.
# You can then later explore how your results would look like without some outliers in the data.
# (Working with scripts makes this easy too!)


### 4. PRESENTING DISTRIBUTIONS

# As a last topic, we look at how to present variable distributions in R a little more
# elegangtly then before.

# a. frequency tables
# you may want to put a small frequency table in a survey report, like this one:
table(data$AGEEULR)
# in this case it is easiest, to just copy the values from R to another software
# where you can format the table as you like (for example Excel or Word)
# you can also directly output your table in a file to be opened by e.g. Excel
to.save <- table(data$AGEEULR) # save the table in an object
write.table(to.save,                               # write this object
            file='age_table.csv',                   # to this file
            sep = ',', dec='.', row.names = FALSE) # with some useful optional arguments
                                                   # (check ?write.table for more)

# b. histograms
# we have seen a simple histogram of work hours, but it looked a bit untidy
# we can try to make it somewhat nicer
hist(data$TOTHRS,                                        # the data to be plotted
     main='Histogram of hours worked in the past week',  # main title of figure
     xlab='Hours worked',                                # title of x axis
     ylab='Frequency',                                   # title of y axis
     xlim=c(0,100),                                      # visible limits of the x axis
     ylim=c(0,4000),                                     # visible limits of the y axis
     col = 'lightblue')                                  # colour of the bars

# which colors can you use?
colors()
# note that these are just the standard named colours in R, you can define any colour you want
# you can also define your own "color palettes", spectrum of colors, arbitrarily
# however, this topic is beyond the scope of the course
# if you are interested in colours in R, try googling "color palettes in R"

# how to save a figure in a file?
# a pdf
pdf('hours_histogram.pdf', width=6, height=6) # sizes are in inches
hist(data$TOTHRS,
     main='Histogram of hours worked in the past week',
     xlab='Hours worked',
     ylab='Frequency',
     xlim=c(0,100),
     ylim=c(0,4000),
     col = 'lightblue')
dev.off() # always close the file after saving the figure in it!
# a png
png('hours_histogram.png', width=500, height=500) # sizes are in pixels
hist(data$TOTHRS,
     main='Histogram of hours worked in the past week',
     xlab='Hours worked',
     ylab='Frequency',
     xlim=c(0,100),
     ylim=c(0,4000),
     col = 'lightblue')
dev.off() # always close the file after saving the figure in it!

# note: there are many other parameters you can tweak on plots, such as the font size
#       you can check the help page for graphical parameters by typing ?par in the console

# c. bar charts
# just a quick discussion of barplots: plotting frequency tables
barplot(to.save) # we save the age freuqency table in an object earlier
# note that this is the same as
barplot(table(data$AGEEULR))

# MINITASK: use the graphical parameters from the histogram example and the ?par help page
#           to make your bar chart look nicer

# A final note on figures: the base figure plotting in R is acceptable but not too fancy.
# In fact, many people prefer nicer looking figures in their paper. A popular R package that
# makes better looking graphs is called ggplot2. However, it takes some time to learn how
# to use it, which is beyond our scope. If you are interested in making better figures in R,
# you can read about and try out ggplot2 on your own.


# we are done with the script, you can save your workspace to have it for the future
save.image('MyLFSdata.RData')


### SECTION SUMMARY

###
# In this section, we learned how to perform a few basic steps of data processing in R.
# In practice, these steps always differ from dataset to dataset, so you will likely have
# to learn a few more things every time you process data from a new survey. However, the
# basics we covered here should help you get started with any dataset.
###


### END OF SCRIPT.