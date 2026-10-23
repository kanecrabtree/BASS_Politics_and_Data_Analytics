
#H===================================
##> Learning outcome ----
#H===================================
      # c(1, 2, 3)
      # head( )
      # tail( )
      # dim( )
      # names( )
      # str( )
      # summary( )
      # data.frame()
      # View()
      # table()
      # barplot()
      # hist()

#H--------------------------------------------
## > Preliminary: ----
#H--------------------------------------------
# 1. Download materials from BB.
# 2. Set your current path

#H--------------------------------------------
## > Shortcuts ----
#H--------------------------------------------
      # Run code      : Ctrl + Enter
      # (Un)Comment   : Ctrl + /
      # Type <-       : Alt  + -

#H===================================
# > Prep ----
#H===================================
# To add comments, press Ctrl + /

# Set your current path
setwd("P:/R_AST")

# Check the path
getwd()

# YOUR CODE STARTS HERE.
#H===================================
## > Get data into R
#H===================================
c(101, 102, 103, 104, 105)
c(101, 102, 103, 104, 105)

id  <- c(101, 102, 103, 104, 105)
id  <- c(101, 102, 103, 104, 105)

age  <- c(10, 10, 11, 12, -999)
age  <- c(10, 10, 11, 12, -999)

truant  <- c("Yes", "No", "No", "No", -999)
truant  <- c("Yes", "No", "No", "No", -999)


df <- data.frame(id, age, truant)
df <- data.frame(id, age, truant)
class(df)
class(df)

View(df)
View(df)

# Define missingness
df[df == -999] <- NA
df[df == -999] <- NA

mi<- colSums(is.na(df))
mi<- colSums(is.na(df))

names(df)
names(df)
str(df)
str(df)
head(df)
head(df)
tail(df)
tail(df)
summary(df)
summary(df)

mean(df$age) # error. why?
mean(df$age)

mean(df$age, na.rm = TRUE)
mean(df$age, na.rm = TRUE)

# Examine univariate distributions
# and basic visualisation

table(df$age)
addmargins(table(df$age))
cbind(addmargins(table(df$age)))
prop.table(table(df$age))
cbind(addmargins(prop.table(table(df$age))))

agec <- cbind(addmargins(table(df$age)))
agep <- cbind(addmargins(prop.table(table(df$age))))

hist(df$age)

table(df$truant)
barplot(table(df$truant))

library(haven)
temp <- read_dta("youth.dta")
View(temp)

keepvar <- c("pidp", "country", "urban_dv", "dvage", "ypsex", "yphsw", "yphap", "yphlf", "ypevrsmo", "yplvhm", "ypvte6", "ypsocweb", "ypnetcht", "yptruant", "ypargm", "ypargf", "ypuni", "ypmobu")
youth <- temp[, keepvar]
names(youth)

youth[youth == -9] <- NA
mi <- colSums(is.na(youth))
summary(youth)
hist(mi)
barplot(mi)
dim(df)
data.frame(mi)
View(mi)
view(df)
addmargins(df)

table(youth$ypvte6)
cbind(addmargins(prop.table(table(youth$ypvte6))))
cbind(addmargins(table(youth$ypvte6)))
barplot(table(youth$ypvte6))
hist(youth$ypvte6)
