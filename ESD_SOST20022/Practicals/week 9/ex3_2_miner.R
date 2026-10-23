
####################################
### Example1: Scots Miners data  ###
####################################

# check your working directory and change it if it's not set to where the data is!
rm(list=ls())
getwd()
setwd()


## 1. Look for a dataset

# The dataset we used for "2_R_RealData.R"

## 2. Download the data and read it into R
library(haven)
minerdata <- read.table("MinersData.RData", header = TRUE, sep=",", stringsAsFactors = FALSE)

## 3. Select two nominal/ordinal and two continuous variables from the dataset

# nominal:
marital <- minerdata$Marstat
parish <- minerdata$Par

# continuous:
age <- minerdata$Age
count <- minerdata$Count # This variable may not be meaningful as it is the identifier of each case, 
                         # we only use it for demonstration purpose.

# Explore the variables
table(marital, useNA = "always")
barplot(table(marital), main = "Marital status")
table(parish, useNA = "always")
barplot(table(parish), main = "Parish")
hist(age, main = "Age")

## 4. Select two nominal/ordinal variables and test their independence - chisq.test()

# H0: parish and marital are independent
# H1: pairsh ang marital are not independent

# contingency table
table(parish,marital)
# Chi-squared test
parmar <- chisq.test(parish,marital)
parmar
# The expected count for one cell is less than 1. Chi-sq test might not be suitable

# recode data 
# if you want to exclude the parish with fewer respondents, we can drop it. (you don't have to 
# do this, it's up to your research questions. We only do this to demonstrate the data recoding)
parish4 <- parish
parish4[parish4=="crm"] <- NA 
barplot(table(parish4), main = "Parish")

marital3 <- marital
marital3[marital3=="o"] <- NA

table(parish4,marital3)
parmar <- chisq.test(parish4,marital3)
parmar
# the test statistic is 15.918, with (4-1)*(3-1)=6 degrees of freedom
# p-value is 0.0142 - probability of getting a more extreme test stat is 1.4%
# lower than 5% -> reject H0, the two variables are related (more single people were in dgs and tb)


## 5. TESTING THE DIFFERENCE BETWEEN MEANS - t.test() 

# H0: single and married people have the same age
# H1: single and married people have the different age

# age of single people
age_s <- age[marital=="s"]
# age of married people
age_m <- age[marital=="m"]

agemar <- t.test(age_s,age_m)
agemar
# mean age for single: 20.2, mean age for married: 37.7
# p-value is  2.2e-16, lower than 5% --> reject H0 - Age of single and married people are different.


## 6. Select two continues variables and test if their correlation is zero - cor.test()
# H0: count and age are uncorrelated
# H1: count and age are correlated

age_count <- cor.test(age, count)
age_count
# correlation is 0.019 (close to 0)
# p-value is 0.17 > 0.05 -> cannot reject H0, we cannot rule out that the variables are uncorrelated


# Save your workspace before you close R
save.image("MyData.RData")
# and remove all of the objects
rm(list=ls())



### END OF SCRIPT

