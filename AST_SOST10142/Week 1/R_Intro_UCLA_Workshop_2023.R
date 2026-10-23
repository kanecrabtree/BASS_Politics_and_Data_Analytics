## INSTRUCTIONS: 
## 1. TO RUN A COMMAND, PLACE CURSOR INSIDE COMMAND
##    OR HIGHLIGHT COMMAND(S) AND HIT CTRL-ENTER (COMMAND-ENTER FOR MACS)
## 2. TO RUN ALL CODE FROM BEGINNING OF FILE TO CURRENT LINE,
##    HIT CTRL-ALT-B
## 3. COMMANDS THAT BEGIN WITH "" ARE COMMENTS AND WILL NOT BE EXECUTED
## 4. NOTE: A FEW COMMANDS PURPOSEFULLY RESULT IN ERRORS FOR TEACHING PURPOSES
## 5. USE CTRL-F TO FIND

## # uncomment (remove ##) to run
## install.packages("dplyr", dependencies=TRUE)
## install.packages("ggplot2", dependencies=TRUE)
## install.packages("rmarkdown", dependencies=TRUE)

## library(dplyr)
## library(ggplot2)

## # list all available vignettes
## vignette()

# Check your directory
getwd()

# Put operators like + at the end of lines
2 +
  3

# specifying arguments by name
log(x = 100, base = 10)

# specifying arguments by position
# Recall, 2*2*2=8, 2^3=8,
# Get the exponent 3
log(8, 2)

# create a vector
first_vec <- c(1, 3, 5)
first_vec

# length() returns the number of elements
char_vec <- c("these", "are", "some", "words")
length(char_vec)

# the result of this comparison is a logical vector
first_vec > c(2, 2, 2)

# first argument to rep is what to repeate
# the second argument is number of repetitions
rep(0, times = 3)
rep("abc", 4)

# arguments for seq are from, to, by
seq(from = 1, to = 5, by = 2)
seq(10, 0, -5)

# colon operator
3:7

# you can nest functions
rep(seq(1, 3, 1), times = 2)

# create a vector 10 to 1
# putting () around a command will cause the result to be printed
(a <- seq(10, 1, -1))

# second element
a[2]

# first 5 elements
a[seq(1, 5)]

# first, third, and fourth elements
a[c(1, 3, 4)]

scores <- c(55, 24, 43, 10)
scores[c(FALSE, TRUE, TRUE, FALSE)]

# this returns a logical vector...
scores < 30

# ...that we can now use to subset
scores[scores < 30]

## # basic syntax of read.csv, not run
## data <- read.csv("/path/to/file.csv")
##
## # specification for tab-delimited file
## dat.tab <- read.delim("/path/to/file.txt",  sep="\t")

dat_csv <- read.csv("https://stats.oarc.ucla.edu/stat/data/hsbraw.csv")

## # write a csv file
## write.csv(dat_csv, file = "path/to/save/filename.csv")
##
## # save these objects to an .Rdata file
## save(dat_csv, mydata, file="path/to/save/filename.Rdata")

## View(dat_csv)

# first 2 rows
head(dat_csv, 2)

# last 8 rows
tail(dat_csv, 8)

# use data.frame() to create a data frame manually
mydata <- data.frame(
  patient = c("Smith", "Jones", "Williams"),
  height = c(72, 61, 66),
  diabetic = c(1, 0, 0)
)


# row 3 column 2
mydata[3, 2]

# first two rows of column height
mydata[1:2, "height"]

# all rows of columns patient and diabetic
mydata[, c("patient", "diabetic")]


# subsetting creates a numeric vector
mydata$height

# just the second and third elements
mydata$height[2:3]

# get column names
colnames(mydata)

# assign column names (capitalizing them)
colnames(mydata) <- c("Patient", "Height", "Diabetic")
colnames(mydata)

# to change one variable name, just use vector indexing
colnames(mydata)[3] <- "Diabetes"
colnames(mydata)

# number of rows and columns
dim(mydata)

# d is of class "data.frame"
# all of its variables are of type "integer"
str(mydata)

# this will add a column variable called logwrite to d
mydata$logHeight <- log(mydata$Height)

# now we see logwrite as a column in d
colnames(mydata)

# d has 200 rows, and the rep vector has 300
mydata$z <- rep(0, 5)


# load packages for this section
library(dplyr)

# creating some data manually
dog_data <- data.frame(
  id = c("Duke", "Lucy", "Buddy", "Daisy", "Bear", "Stella"),
  weight = c(25, 12, 58, 67, 33, 9),
  sex = c("M", "F", "M", "F", "M", "F"),
  location = c("north", "west", "north", "south", "west", "west")
)



# dogs weighing more than 40
filter(dog_data, weight > 40)

# female dogs in the north or south locations
filter(dog_data, (location == "north" | location == "south") & sex == "F")

# select 2 variables
select(dog_data, id, sex)

# select everything BUT id and sex
select(dog_data, -c(id, sex))

# make a data.frame of new dogs
more_dogs <- data.frame(
  id = c("Jack", "Luna"),
  weight = c(38, -99),
  sex = c("M", "F"),
  location = c("east", "east")
)


# make sure that data frames have the same columns
names(dog_data)
names(more_dogs)

# appended dataset combines rows
all_dogs <- rbind(dog_data, more_dogs)
all_dogs

# new dog variable
# matching variables do not have to be sorted
dog_vax <- data.frame(
  id = c("Luna", "Duke", "Buddy", "Stella", "Daisy", "Lucy", "Jack", "Bear"),
  vaccinated = c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE)
)

# id appears in both datasets, so will be used to match observations
dogs <- inner_join(all_dogs, dog_vax)
dogs

# subset to science values equal to -99, and then change
#  them all to NA
dogs$weight[dogs$weight == -99] <- NA
dogs$weight

# a sum involving "undefined" is "undefined"
1 + 2 + NA

# NA could be larger or smaller or equal to 2
c(1, 2, 3, NA) > 2

# mean is undefined because of the presence of NA
dogs$weight
mean(dogs$weight)

# NA values will be removed first
sum(c(1, 2, NA), na.rm = TRUE)

mean(dogs$weight, na.rm = TRUE)

# one of the values is NA
x <- c(1, 2, NA)

# check for equality to NA using == is wrong
# RStudio may give you a warning about this (to use is.na() instead)
x == NA

# this is correct
is.na(x)

# create a new bloodtest data set
bloodtest <- data.frame(
  id = 1:10,
  gender = c("female", "male", "female", "female", "female", "male", "male", "female", "male", "female"),
  hospital = c("CLH", "MH", "MH", "MH", "CLH", "MH", "MDH", "MDH", "CLH", "MH"),
  doc_id = c(1, 1, 1, 2, 2, 2, 3, 3, 3, 3),
  insured = c(0, 1, 1, 1, 0, 1, 1, 0, 1, 1),
  age = c(23, 45, 37, 49, 51, 55, 56, 37, 26, 40),
  test1 = c(47, 67, 41, 65, 60, 52, 68, 37, 44, 44),
  test2 = c(46, 57, 47, 65, 62, 51, 62, 44, 46, 61),
  test3 = c(49, 73, 50, 64, 77, 57, 75, 55, 62, 55),
  test4 = c(61, 61, 51, 71, 56, 57, 61, 46, 46, 46)
)


mean(bloodtest$age)
median(bloodtest$age)
var(bloodtest$age)

summary(bloodtest$test1)

# just a single correlation
cor(bloodtest$test1, bloodtest$test2)

# use dplyr select() to pull out just the test variables
scores <- select(bloodtest, test1, test2, test3, test4)
cor(scores)

# table() produces counts
table(bloodtest$gender)
table(bloodtest$hospital)

# for proportions, use output of table()
#   as input to prop.table()
prop.table(table(bloodtest$hospital))

# this time saving the freq table to an object
my2way <- table(bloodtest$gender, bloodtest$hospital)

# counts in each crossing of prog and ses
my2way

# row proportions,
#   proportion of prog that falls into ses
prop.table(my2way, margin = 1)

# columns proportions,
#   proportion of ses that falls into prog
prop.table(my2way, margin = 2)



# program and ses class appear to be associated
chisq.test(bloodtest$hospital, bloodtest$insured)

# formula notation for independent samples t-test
t.test(test1 ~ gender, data = bloodtest)

t.test(bloodtest$test1, bloodtest$test3, paired = TRUE)

# fit a linear model (ANOVA and linear regression)
m1 <- lm(test1 ~ age + gender, data = bloodtest)
# printing an lm object will list the coefficients only
m1

# summary produces regression table and model fit stats
summary(m1)

# just the coefficients
coef(m1)

# 95% confidence intervals
confint(m1)

# first 5 observed values, predicted values and residuals
# cbind() joins column vectors into a matrix
cbind(bloodtest$test1, predict(m1), residuals(m1))

# ANOVA sequential sums of squares
anova(m1)

# fit another linear regression model, adding hosiptal as predictor (two parameters added to model):
m2 <- lm(test1 ~ age + gender + hospital, data = bloodtest)

# printing an lm object will list the coefficients only
anova(m2, m1)

# plots all 4 plots at once (otherwise one at a time)
layout(matrix(c(1, 2, 3, 4), 2, 2))

# 4 diagnostic plots
plot(m1)

layout(1)

# family=binomail uses link=logit by default
m_ins <- glm(insured ~ age, data = bloodtest, family = binomial)

summary(m_ins)

# ORs
exp(coef(m2))

# confidence intervals on ORs
exp(confint(m2))

plot(bloodtest$test1, bloodtest$test2)

plot(bloodtest$test1, bloodtest$test2,
  xlab = "Test 1",
  ylab = "Test 2",
  main = "Plot of Test1 vs Test2"
)

plot(bloodtest$test1, bloodtest$test2,
  xlab = "Test 1",
  ylab = "Test 2",
  main = "Plot of Test1 vs Test2",
  col = "steelblue",
  pch = 17
)

hist(bloodtest$test1)

boxplot(bloodtest$test2 ~ bloodtest$insured)

boxplot(bloodtest$test2 ~ bloodtest$insured,
  xlab = "Insured",
  ylab = "Test 2",
  main = "Boxplots of Test2 by Insurance Status",
  col = "lightblue"
)

tab <- table(bloodtest$gender, bloodtest$hospital)
barplot(tab,
  legend.text = TRUE
)


tab <- table(bloodtest$gender, bloodtest$hospital)
barplot(tab,
  legend.text = TRUE,
  beside = TRUE,
  col = c("lawngreen", "sandybrown"),
  xlab = "hospital"
)


# a scatterplot of math vs write
ggplot(data = dat_csv, aes(x = math, y = write)) +
  geom_point()

# a scatterplot of math vs write with best fit line
ggplot(dat_csv, aes(x = math, y = write)) +
  geom_point() +
  geom_smooth(method = "lm")

# a scatterplot and best fit line, by gender
#  color affects the best fit line, fill affects the confidence intervals
ggplot(dat_csv, aes(x = math, y = write, color = female, fill = female)) +
  geom_point() +
  geom_smooth(method = "lm")

# panel of scatterplot and best fit line, colored by gender, paneled by prog
ggplot(dat_csv, aes(x = math, y = write, color = female, fill = female)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~prog)

# panel of scatterplot and best fit line, colored by gender, paneled by prog
ggplot(dat_csv, aes(x = math, y = write, color = female, fill = female)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~prog) +
  theme_classic()

# panel of scatterplot and best fit line, colored by gender, paneled by prog
ggplot(dat_csv, aes(x = math, y = write, color = female, fill = female)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~prog) +
  theme_dark()

## # a scatterplot of read vs write
## ggplot(data=dat_csv, aes(x=read, y=write, color=ses)) +
##    geom_point() +
##    geom_smooth(method=lm, se=FALSE)

barplot(HairEyeColor[, , 1],
  col = c("#4d4d4d", "#bf812d", "#f4a582", "#f6e8c3"),
  legend.text = TRUE, xlab = "Eye Color",
  args.legend = list(title = "Hair Color")
)
