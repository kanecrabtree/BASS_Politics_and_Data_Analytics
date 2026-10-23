#                          ############################################                            #
#                          ###  A VERY BRIEF INTRODUCTION TO R II.  ###                            #
#                          ###        WORKING WITH REAL DATA        ###                            #
#                          ############################################                            #

###
# This script was originally prepared for the second introductory part of the course on social
# network analysis in R and RSiena held in Budapest on 3-5 December 2014.
#
# The script was prepared by Andras Voros.
# (this is the version of 12.02.2021)
###

###
# We have discussed technicalities of storing data in objects in R, but you never enter
# an actual dataset by hand (it would be tedious and silly). The data we work with is
# almost always prerecorded in certain files on our computer (or perhaps the internet).
# So, you have to learn how to read and edit external files in R. Having loaded the data,
# there are some standard operations that you usually have to perform before an analysis.
# We cover the basics of these topics in the present script.
###


### 1. SETTING THE WORKING DIRECTORY

# it is possible to set up a WORKING DIRECTORY in an R session
# if no path (e.g. "C:\blabla\") is given before a file name,
# R will look for the file in the current working directory
# so, it is useful to set the wd to where your data and/or script files are -
# no need to type folder names anymore!

getwd() # what is the current working directory?

# let's set the working directory to where the downloaded R scripts are for this course
setwd("C:/YOUR FOLDER HERE/") # note: folder location between quotation marks
# we use slash (/) - this works on both Macs and other machines as well
# you can also use double backslash (\\) (WHY double?? look at ?Quotes)
getwd() # here we are

# we can have a look at the files and folders in our current working directory
list.files()


### 2. IMPORTING DATA FROM EXTERNAL FILES TO THE WORKSPACE

# there are many different data formats out there, most of which can be imported into R somehow
# at the end of the script you can find information about where to look for help if you don't know
# how to open a specific type of file
# data often comes in .dat format, and you can frequently encounter .RData and .csv files
# these three file types are all very easy to read and write from R

# now we import some data from .dat files

### The Scots Miners 1891 Census Survey dataset
# The dataset used for the illustration of sampling methods throughout the course is a subsamples 
# of the Scots Minders 1891 Census Survey conducted in Scotland. The dataset contains individual
# information (age, marital status, etc.) about minerworkers living in different areas of Scotland,
# as surveyed in 1891. We use a 5,000-unit subsample of the complete dataset.
#
# Further information about the data and see the UK Data Service's archive:
# https://beta.ukdataservice.ac.uk/datacatalogue/studies/study?id=3651#!/details
###

# the variables are in a single data table, which we can read like this:
data <- read.table("miners_data.csv", header = TRUE, sep=",", stringsAsFactors = FALSE)
# a bit complicated, but accept the mistery for now
# read.table() returns an object that is called a data frame
?read.table

# what is a data frame?
mode(data) # it is a list
class(data) # with its own class "data.frame"
# data frames are special objects in R designed to handle classic 2-dimensional data tables,
# where we have observations (rows) by variables (columns)
# it is convenient to call one of the variables in a data frame, using the $ operator
data$Age # that is a lot data in the Age variable

# data frames are useful especially because they can store vectors of different modes
# most other objects can only contain data of one given mode
# for example, transforming our data frame into a matrix...
data.mat <- as.matrix(data)
mode(data.mat)
# ... leads to a character matrix, where every variable (incl. Age) is treated as a string
rm(data.mat) # we can remove this object

# let's look at the size of the data object
dim(data) # 5057 observations of 8 variables
nrow(data) # a shorthand for the number of rows
ncol(data) # and one for the number of columns

# what kind of data is stored in these variables?
head(data)
# most strings are coded (we will need to consult the codebook to understand the values)
# but age seems self-evident - let's take a closer look at this variable


### 3. MANIPULATING THE DATA - SUBSETTING OBJECTS

# we would only like to use the Age column (variable) of the dataset

# it is possible to refer to cells, rows, or columns of an object
data[1,2] # cell in the first row and second column
data[6,] # the sixth row
data[,1] # the first column (too much data)

# we put the Age column of object "data" into a separate object
# there are two ways to do this
# 1. works for both matrices and data frames:
age <- data[,5]
head(age)
# 2. works only for data frames:
age <- data$Age
head(age) # same as the above
class(age) # this contains integers; it is now a vector object and not part of the data frame

# we can refer to elements of a vector in the same way as to cells of a matrix
age[3] # but vectors are 1-dimensional objects, of course
age[1:5]
age[c(1,3,5,7)]
# the latter also works for matrices and data frames
data[1:5, c(1,3,5,7)]

# using this, it is easy to change data entries
age[3] <- 4
age[5:6] <- 5
data[, 5] <- 6
data[4:7, 5] <- 7
data[c(1,3,5,7,9), 7:8] <- 8  # Did you come up with an error? Can we change a character to a number?

# this is what we got:
age[1:10] # 3rd element changed to 4, 5th and 6th element changed to 5
data[1:10,] # 5h column is all 6s except 4th-7th elements; columns 7 and 8 have a few 8s


### 4. RECODING THE DATA - LOGICAL STATEMENTS AND SUBSETTING

# referring to certain elements in a vector, matrix, or data frame 
# is very important when you want to recode your data,
# but you don't have to change every value one by one
# LOGICAL STATEMENTS help to identify the location of values in the data
# that you might want to change

# a logical statement in R looks like these
7>6
6<=7

# now, which cells of the data table have a value of 5?
data==6 # note the double equal sign
# which entries are equal to or smaller than 4?
data<=7
# which entries in the age vector are either 4 or 5?
age %in% c(4,5) # == is not good in such cases


# using logical statements, we can recode unwanted values in our objects,
# even if we don't know where they are
#________________________________________________________________________________________________
#________________________________________________________________________________________________
#________________________________________________________________________________________________
# 
#                                       ###
#                                      #####
#                                     #######
#                                    #########
#                                   ###########
#                                  #############
#                                 ###############
#                                #################
#                               ###################
#                               ###################
#                               ###################
#                                #################
#                                 ###############
#                                  #############
#                                   ###########
#                                    #########
#                                     #######
#                                      #####
#                                       ###
#
#                                      #####
#                                     #######
#                                    #########
#                                     #######
#                                      #####
# 
#        The next following lines of codes can only be applied to DataFrames and not lists.
#        So, we need to convert the lists to DataFrames with the following syntax:
#                             data <- as.data.frame(data)
#________________________________________________________________________________________________
#________________________________________________________________________________________________
#________________________________________________________________________________________________

data[data==6] <- 999 
data[data==7] <- 999
data[data==8] <- 999
age[age %in% c(4,5)] <- 99
# note: the first three can be done in a single line, but this needs a bit more R experience
# (or a matrix object)

# here is the result
age[1:10]
data[1:10,]

# Why do you have to write "data" and "age" twice? because you need to specify the object you want to
# change and the positions where you would like to change it. The first recoding line can be read as:
# "R, change the cells of data which equal to 6 to 999.", or a longer sentence for the last one:
# "R, change the cells of age which are in the positions where age is 4 or 5 to 99."

# the longer sentence shows that this procedure is more general: the first "data" could be replaced
# by another object's name
# for example, create an empty matrix and change its cells to 1 where "data" is 999
newMatrix <- matrix(0, nrow(data), ncol(data))
newMatrix[data==999] <- 1
newMatrix[1:10,]


### 5. MISSING VALUES

# the last topic to cover is that of missing values
# which have a special value of NA in R

# let's set the values of 99, 999 to NA in our objects
age[age==99] <- NA
data[data==999] <- NA
age[1:10]
data[1:10,] # note: in case of character columns (such as "Bpl"), NAs are printed as <NA>

# you can also check by a logical statement where the NAs are in your data
# but whatch out, because NA is not a value cells can be equal to
age[1:10]==NA # WRONG
# is not simply a character string
age[1:10]=="NA" # WRONG
# but it is a unique value recognized by R
age[1:10] %in% NA # RIGHT
# it is perhaps even easier this way:
is.na(age[1:10]) # also RIGHT

# how many NAs are in the age variable?
(missings <- sum(is.na(age)))
# WHYY?? the result of is.na(age) is an object of logical mode (has TRUE/FALSE values)
# the function sum() works only for numeric mode objects,
# therefore it tries to force (coerce) our logical object to be numeric
# TRUE and FALSE values turn into 1 and 0 when coerced to numeric mode

# and what is the total age of people in the dataset
sum(age)
# for most functions you need to tell what to do if they encounter NAs
# e.g. sum just does what normal addition (the "+" operator) would do, but saves you time and space
# if sum encounters one NA the final result will be NA
# to simply skip NAs in the data, do this:
(total_age <- sum(age, na.rm=TRUE))


# MINITASK: How do you count the number valid, non-missing values in the age vector?
nonmissings <- "???"
nonmissings

# we can now calculate the proportion of NAs in the data
missings / (missings + nonmissings)

sum(is.na(data)) # Counts NAs
sum(!is.na(data)) # Counts Non-NA
sum(is.na(data)) / (sum(is.na(data)) + sum(!is.na(data)))


### 6. HANDLING DIFFERENT FILE FORMATS AND OTHER THINGS

# you can import and export data from and to several types of files, other than .csv

# we will learn about reading other types, such as .RData and .xlsx
# you can check the function load() to see how to read R's own .RData files

# reading and writing Excel tables requires an additional package called "xlsx"

# R also supports importing data from files created by popular statistical packages
# to use these special functions, you need the package called "foreign"
# if you don't have it, download it, then load it by the command library(foreign)
# two of the many options:
# read.spss() - reads SPSS data files
# read.dta() - reads stata data files
# be careful to specify the right arguments!


### SECTION SUMMARY

###
# With the help of this script, you have familiarized yourselves with the following:
# creating objects in R from external files (.csv; later we will also use .RData and .xlsx)
# accessing specfic parts (subsets) of your objects (vectors, matrices, data frames)
# modifying and correcting your data using logical statements
# missing values (NAs) in R
# further options for importing data from external files
#
# note: we did not try out how exporting data from R to a file works, but if you need to do so,
#       it is really easy using the packages mentioned in the last part
###

# We are done with the basics, you can clear your workspace if you would like to.

### END OF SCRIPT - PLEASE OPEN: "exercise1.R"