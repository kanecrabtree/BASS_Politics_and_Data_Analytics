############################## INSTALL PACKAGES (ONCE!)
install.packages("haven")        # to read .dta data file
install.packages("tidyverse")    # data manipulation
install.packages("psych")        # descriptive statistics  
install.packages("tableone")     # descriptive statistics
install.packages("janitor")      # cross-tabulation
install.packages("ggplot2")      # data visualization - graphs
install.packages("gridExtra")    # combine graphs



############################## LOAD PACKAGES (MUST LOAD EVERY SESSION!)
library("haven")     
library("tidyverse")  
library("ggplot2")    
library("gridExtra")  
library("janitor")    
library("psych")      
library("tableone") 



############################## SET WORKING DIRECTORY
### anyone who uses the pc in the classroom should type the following command
setwd("P:/R_AST")

# an example for someone who uses windows laptop
# setwd("C:/My_documents/Second_Semester/R_AST")

# an example for someone who uses macbook
# setwd("/Users/raniasfakianaki/Downloads/_teaching")

# or you can set your working directory from the menu 
# go to tools --> global options


### to check the path of your working directory type the following command
getwd()



############################## LOAD DATA
### types of data we can load: dta, csv, rds

# the command for loading a dta file is read_dta
temp  <- read_dta("youth(3).dta")

temp  <- read_dta("youth(3).dta")
# examples for loading csv and rds files
# temp  <- read.csv("babies_25vars(1).csv")
# temp <- read_rds("youth_cleaned.rds")



############################## DATA MANIPULATION

### 1. changing the name of a variable  
## for example let's simplify the variable names by removing yp prefix
# the command is str_replace

names(temp) <- str_replace(names(temp), "yp", "")

names(temp) <- str_replace(names(temp), "yp", "") 


### 2. lets create a new dataset object in R named youth 
## which will contain specific variables from temp
# the command is select
youth  <- temp %>%
          select(pidp, age = dvage, sex,
                 country,  urban_dv,
                 hsw,      hap,      hlf,
                 evrsmo,   lvhm,     vte6,
                 socweb,   netcht,   truant,
                 argm,     argf,     uni,    mobu)


### 3. Let’s treat missingness
youth[youth == -9] <- NA
youth[youth ==  9] <- NA

youth[youth == -9] <- NA
youth[youth == -9] <- NA
# Remove missing observations
youth <- youth %>% 
  drop_na()  

youth <- youth %>% 
  drop_na()


### 4. Let's create a new variable
# We can create a new variable by using an existing variable.
# We use command mutate. 
# for example, let’s compute centered age, which is the deviation from the mean_age. 
youth <- youth %>%
         mutate(age_ctr = age - mean(youth$age)) 

youth <- youth %>%
         mutate(age_ctr = age - mean(youth$age))

### 5. Recoding
## Recoding is one of the most important procedures in data cleaning. 
# for example, variable lvhm (at what age would you like to leave home?) is numeric 
# and takes values from 10 to 70
# we will recode it to three categories: 0 (10-20), 1 (21-30), and 2 (30+). 
# the name of the new recoded variable will be homeleaving
# we will use commands mutate and if_else
youth  <- youth %>%
          mutate(homeleaving =
                 if_else(lvhm > 9 & lvhm < 21, 0,
                 if_else(lvhm > 20 & lvhm < 31, 1,
                 if_else(lvhm > 30, 2, lvhm)
                 )))

youth <- youth %>% 
         mutate(homeleaving =
                 if_else(lvhm > 9 & lvhm < 21, 0,
                 if_else(lvhm > 20 & lvhm < 31, 1, 
                 if_else(lvhm > 30, 2, lvhm))))  

# Let’s factorise homeleaving by adding labels for each category 
# we will use command factor
youth$fct_homeleaving <- factor(youth$homeleaving,
                               labels = c("10-20","21-30", "30+"))

youth$fct_homeleaving <- factor(youth$homeleaving,
                               labels = c("10-20","21-30", "30+"))

### 6. Let's save the clean data
## As we have just completed the data cleaning process, it’s a good idea to save the 
# cleaned dataset object in R. As this is the cleaned dataset, we can load and 
# use it to perform data analysis at later stages, without having to clean again.

youth_cleaned  <- youth
write_rds(youth_cleaned, file = "youth_cleaned.rds")




############################## DESCRIPTIVE STATISTICS & TABULATION
### 1. let's calculate the mean and standard deviation of variable age
mean(youth$age) 
sd(youth$age)

mean(youth$age)
sd(youth$age)

### 2. let's calculate min, max, median, 1st and 3rd quartiles of variable age
summary(youth$age)

summary(youth$age)

### 3. tabulation: create a frequency table for variable age
table(youth$age)

table(youth$age)

# lets add sum
addmargins(table(youth$age))

addmargins(table(youth$age))

# Let’s arrange the output in a column 
cbind(addmargins(table(youth$age)))

cbind(addmargins(table(youth$age)))

# or print percentage in the table
cbind(addmargins(prop.table(table(youth$age))))

cbind(addmargins(prop.table(table(youth$age))))

# We can combine the above steps and print in one table
agec <- cbind(addmargins(table(youth$age)))
agep <- cbind(addmargins(prop.table(table(youth$age))))
cbind(agec, agep)


### 4. Cross-tabulation
## The main purpose of a crosstab is to examine the relationship between two 
# variables in a table. Let’s produce a cross-tabulation between sex and 
# homeleaving age to investigate a gender difference in the homeleaving age.
# sex: numeric - 1 for males and 2 for females
table(youth$sex, youth$fct_homeleaving)  

table(youth$sex, youth$fct_homeleaving)

############################## DATA VISUALIZATION

### 1. we need to load  dataset babies_25vars.csv and do some data manipulation first
# let's load babies_25vars.csv
b  <- read.csv("babies_25vars(1).csv")

# Next, we generate a low birthweight dummy 
# (Low birthweight defined as less than 2.5kg, or 5 pounds 8 ounces).
b  <- b %>% 
      mutate(low_bwt = ifelse(bkg < 2.5, 1, 2) )

# check the dummy variable
b %>% 
  tabyl(low_bwt)

# Now, factorise the dummy variable.
b$fct_lowbwt <- factor(b$low_bwt,
                       labels = c("Yes", "No"))

# Let's select the variables we need 
# and assign them to a new dataset object in R named baby
baby <- b %>%
        select(id, bkg, age, height,
               weight, fct_lowbwt, fct_smoke) 



### 2. now, let's start visualizing our data

### 2.1 we will start with the simplest commands
hist(baby$age)
boxplot(baby$age)


### 2.2 now, let's use ggplot
ggplot(data = baby,  aes(x = bkg)) +
  geom_histogram() 

# changing the width of the columns
# binwidth
ggplot(data = baby, aes(x = bkg)) + 
  geom_histogram(binwidth = 0.2) 

# changing the colour of the columns
# fill
ggplot(data = baby, aes(x = bkg)) +
  geom_histogram(binwidth = 0.2, fill = "steelblue") 


## We now extend our exploration to bivariate distributions. 
# We define fill or colour options in aes by using a categorical variable, 
# fct_lowbwt. This time, we do not use quotes as we specify variables.
ggplot(data = baby, aes(x = bkg, fill = fct_lowbwt)) +
  geom_histogram()


## Depending on the aim, presenting graphs side by side can be more helpful 
# to illustrate the story. The option, facet_wrap allows to do so.
ggplot(baby, aes(x = bkg)) +
       geom_histogram() +
       facet_wrap (~fct_lowbwt)



## Instead of histogram, we can also use the density plot 
# to inspect distributions of continuous measures. Often called a kernel 
# density plot, density plot illustrates the smoothed distribution 
# of continuous variables. Density plots can represent distributions more 
# clearly and make the differences between categories of the second variable clearer.
ggplot(baby, aes(x = bkg)) +
  geom_density()


## Another simple way to visualise the continuous measures’ distributions 
# is utilizing boxplots. Boxplots prove five summary statistics 
# including minimum, maximum, median, 25th and 75th percentile, 
# displaying the inter-quartile range. Recall, we saw the utility of 
# boxplots already while detecting outliers.
ggplot(data = baby, aes(y = bkg)) +
  geom_boxplot()


# We add a grouping (categorical) variable, fct_smoke in x axis.
ggplot(data = baby,  aes(x = fct_smoke, y = bkg)) +
      geom_boxplot()



# Unlike histogram, density plot, and boxplot, scatterplots require 
# two continuous variables as it depicts the linear relationship between 
# the two continuous measures.
ggplot(data = baby,  aes(x = age, y = bkg)) +
      geom_point()

# We can improve the appearance by moving the data points slightly 
# so they are not overlapping. The option, position = "jitter" does this.
ggplot(data = baby,  aes(x = age, y = bkg)) +
      geom_point(position = "jitter")

# We add a third variable as a grouping (categorical) variable, 
# fct_smoke in colour option.
ggplot(data = baby,
       aes(x = age, y = bkg, color = fct_smoke)) +
  geom_point(position = "jitter")


# We add a third variable as a grouping (categorical) variable, 
# fct_smoke in colour option.
ggplot(data = baby,
       aes(x = age, y = bkg, colour = fct_smoke)) +
       geom_point(position = "jitter", alpha = 0.8) +
       scale_colour_manual(values = c("steelblue", "red"))


##  Visualising Categorical Variables: Barplots
# first, we will create a summary table for variables fct_lowbwt and fct_smoke
# using commands group_by and summarise 
aaa <- baby %>%
  group_by (fct_lowbwt, fct_smoke) %>%
  summarise (count = n() ) %>%
  mutate(perc = (count/sum(count))*100)

aaa

## We define x as the outcome variable, fct_lowbwt. The cluster is indicated 
# by fill = fct_smoke argument. In geom_bar(), we specify position = "dodge" 
# to put the bars side by side for each x-axis category.
ggplot(aaa,
       aes(x = fct_lowbwt, y = perc, fill = fct_smoke)) +
      geom_bar(stat = "identity", position = "dodge") 



## Let’s fine-tune the graph by adjusting bar width and adding labels. 
# For the clustering variable, we instruct R to print the legend label 
# as Smoking status to be more intuitive for readers.
ggplot(aaa,
       aes(x = fct_lowbwt, y = perc, fill = fct_smoke)) +
       geom_bar(stat = "identity", position = "dodge",width = 0.6)  +
       labs(x = "Low birthweight", y = "Percent", fill = "Smoking status")




