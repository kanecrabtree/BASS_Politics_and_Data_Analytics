
########################################################
### Example2: Scottish Social Attitudes Survey, 2016 ###
########################################################


# check your working directory and change it if it's not set to where the data is!
rm(list=ls())
setwd("C:/Users/j53735jz/OneDrive - The University of Manchester/Work/GTA 2021/Week 4")


## 1. Look for a dataset

# SSA: Scottish Social Attitudes Survey, 2016 
# https://beta.ukdataservice.ac.uk/datacatalogue/studies/study?id=8628

## 2. Download the data and read it into R

ssadata <- read.table("ssa2016_for_ukda.tab", header = TRUE)
dim(ssadata)
names(ssadata)

## 3. Select two nominal/ordinal and two continuous variables from the dataset

# nominal
party <- ssadata$PartyIdS  #Party identification (compressed) 
scotsind <- ssadata$Refvot16 #How would you vote in a Scottish Independence referendum if held?

# continuous
age <- ssadata$rage
rweight <- ssadata$EstWt  # How much do you weigh? (converted to kg)

# explore the variables 
## how to visualise a variable?
table(party, useNA = "always")
table(scotsind, useNA = "always")
hist(age)
hist(rweight)

# recoding and addressing missingness
# For scotsind, only keep 1-"yes" 2-"no". Other values indicate different types of missingness
scotsind2 <- scotsind
scotsind2[scotsind %in% c(3,4,8,9)] <- NA
barplot(table(scotsind2), main = "How would you vote in a Scottish Independence referendum?",names.arg = c("yes","no"))

# For rweight, Missing values are set as 998 and 999
rweight[rweight>=998]<-NA
summary(rweight) #121 cases convert to NA
hist(rweight)

# For party, some groups have few people, collapse them into a larger group -> other party
party[party==9] <- NA


party[party %in% c(5,7,8)] <- 5
barplot(table(party), main = "Party Identification",names.arg = c("con","lab","libDem","SNP","other", "none"))


## 4. Select two nominal/ordinal variables and test their independence - chisq.test()
# H0: party identity and the voting for scottish independence are independent
# H1: party identity and the voting for scottish independence are not independent

round(prop.table(table(scotsind2,party),2),2)
scotsparty <- chisq.test(scotsind2,party)
# fisher.test(scotsind,party,simulate.p.value=TRUE)
scotsparty
# the test statistic is 377.09, with 5 degrees of freedom
# p-value is very close to 0, lower than 5% 
# reject H0, the two variables are related


## 5. Testing the difference between means- t.test()
# H0: people who vote yes and who vote no for Scottish independence have same age on average
# H1: people who vote yes and who vote no for Scottish independence have different age on average

# age of those who vote yes for Scottish independence
age_yes <- age[scotsind2==1]

# age of those who vote no for Scottish independence
age_no <- age[scotsind2==2]

meanstestage <- t.test(age_yes, age_no)
meanstestage
# mean age for voting for yes: 47.0, mean for voting for no: 57.1
# p-value is very close to 0, lower than 5% --> reject H0 
# people who vote yes and who vote no for Scottish independence have different age on average


## 6. Select two continuous variables and test if their correlation is zero - cor.test()
# H0: weight and age are uncorrelated
# H1: weight and age are correlated

corweightage <- cor.test(rweight, age)
corweightage
# correlation is 0.008 (close to 0)
# p-value is 0.7953> 0.05 -> cannot reject H0, we cannot rule out that the variables are uncorrelated



# Save your workspace before you close R
save.image("MyData.RData")
# and remove all of the objects
rm(list=ls())
describe(ssadata)
ssadata$ObHlthF2

# weighting packages  (not required)
install.packages("weights")
install.packages("survey")
library("weights") # weighting for simple design
wtd.t.test(x = ssadata$rage, y = 52, weight = ssadata$EstWt) 
wtd.chi.sq(ssadata$NumCh, ssadata$HHIncome, weight = ssadata$EstWt )
wtd.cor(rweight, age, weight=ssadata$wtfactor)

mean(ssadata$rage)
rweight <- ssadata$EstWt 

### END OF SCRIPT

