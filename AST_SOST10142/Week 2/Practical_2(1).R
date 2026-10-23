
#H===================================
##> Learning outcome ----
#H===================================
# By the end of the practical, students should be able to :
# - 1. Manipulate the data using
#      select, arrange, mutate, filter, summarise
# - 2. Transform numeric to factor variables
# - 3. Save the clean dataset
# - 4. Produce a cross-tabulation using %>%
# - 5. Produce a barchart for factor variables using
#       ggplot(aes(x = fct_var)) + geom_bar()
# - 6. Produce a descriptive statistics table

#H--------------------------------------------
## > Preliminary: ----
#H--------------------------------------------
# 1. Download materials from BB.
# 2. Set your current path
# 3. Customise Pane Layout.. (Code, Console side-by-side)
#    minimise other panes
# 4. Change Appearance by applying custom theme

#H--------------------------------------------
## > Shortcuts ----
#H--------------------------------------------
      # (Un)Comment   : Ctrl + /
      # Type <-       : Alt  + -

      # Type %>%      : Ctrl + Shift + M
      # Clean Console : Ctrl + L

      # Help example  : ?select

#H===================================
## > Prep ----
#H===================================
# To add comments, press Ctrl + /

# Remove objects
rm(list = ls())

# Set your current path
setwd("P:/R_AST")

# Check the path
getwd()

# install packages
  # install.packages("haven")   # To read .dta data
  install.packages("tidyverse") # modern data manipulation
  install.packages("janitor ")  # cross-tabulation
  install.packages("tableone")  # descriptive statistics

# Load packages (MUST LOAD EVERY SESSION!)
library("haven")      # To read .dta data file
library("tidyverse")  # data manipulation
library("janitor")    # cross-tabulation
library("tableone")   # descriptive statistics

# YOUR CODE STARTS HERE
#H===================================
## > Data manipulation ----
#H===================================
library("haven")
  
temp  <- read_dta("youth.dta")
names(temp) <- str_replace(names(temp),"yp","")

select order rename and keep variables 
prac <- temp%>%
  select(pidp, age = dvage, sex, everything())
prac <- temp %>% 
   select(pidp, age = dvage, sex)

youth <- temp %>%
  select(pidp, age = dvage, sex, country, urban_dv, hsw, hap, hlf, evrsmo, lvhm, vte6, socweb, netcht, truant, argm, argf, uni, mobu)
youth[youth == -9] <- NA
youth[youth == 9] <- NA 
glimpse(youth)

arrange: sort variables 
test <- youth
prac <- test %>% 
        arrange (age,country)
  head(prac, n = 3)
 
filter keep and remove observations
prac <- test %>% 
  arrange(age, country) %>% 
  filter(age == 10)
  
    table(prac$age)
 
 prac2  <- test %>%
   arrange(age, country) %>%
   filter(age != 10)
 table(prac2$age)
  
 table(test$age)
  
mutate create a new variable.
mean(test$age)
test$mean_age <- mean(test$age)

youth3 <- test %>% 
  mutate(age_ctr = age - mean_age)

youth2 <- test %>% 
  mutate(age_ctr = age - mean_age) %>% 
  select(pidp, age, mean_age, age_ctr, everything() ) 
  
summarise obtainn summary statistics 
test %>% 
  summarise(mean_age2 = mean(age, na.rm = TRUE))
 
mean_age2 <- test %>% 
  summarise(mean_age2 = mean(age, na.rm = TRUE))
youth_mean_age2 <- cbind(mean_age2, test)
 
 group_by and summarise: obtain group summary statistics 
 test %>% 
   group_by(age) %>% 
   summarise(mn_hlf = mean(hlf, na.rm = TRUE), 
            count_hlf = n())
 
 test %>% 
   group_by(uni) %>% 
   summarise(mn_lvhm = mean(lvhm, na.rm = TRUE),
             count_lvhm = n())
 
#H===================================
## > Remove missing observations ----
#H===================================
df <- youth %>% drop_na()
 dim(df)

#H===================================
## > Recode ----
#H===================================
table(df$sex)
df %>% tabyl(sex)
df %>% tabyl(sex) %>% adorn_totals()
 
df$sex_ <-df$sex
df$sex [df$sex == 1] <- 0
df$sex [df$sex == 2] <- 1

df %>% tabyl(sex_, sex)

df <- df %>% 
  mutate(homeleaving = 
           if_else(lvhm > 9 & lvhm < 21, 0, 
            if_else(lvhm > 20 & lvhm < 31, 1, 
              if_else(lvhm > 30, 2, lvhm))))
 
df %>% tabyl(lvhm, homeleaving)
df %>% tabyl(lvhm, homeleaving) %>% adorn_totals()
df %>% tabyl(lvhm, homeleaving) %>% prop.table() %>% adorn_totals()
df %>% tabyl(homeleaving) %>% adorn_totals
#H===================================
## > convert numeric to factor varibales 
#H===================================
df$fct_homeleaving <- factor(df$homeleaving, 
                      labels = c("10-20", "21-30", "30+"))
attributes(df$fct_homeleaving)
attributes(df$homeleaving)

df %>% tabyl(homeleaving, fct_homeleaving)

df$fct_netcht <- factor(df$netcht, labels =
                 c("none", 
                    "less than an hour", 
                    "1-3 hours",
                    "4-6 hours",
                    "7 or more hours"))

df %>% tabyl(fct_netcht, netcht)
df %>% tabyl(fct_netcht) %>% adorn_totals()
df %>% tabyl(netcht) %>% adorn_totals()

df$fct_sex <- factor(df$sex, labels = c ("male", "female"))
attributes(df$fct_sex)
df %>% tabyl(fct_sex, sex)

#H===================================
## > save the clean dataset 
#H===================================
youth_cleaned <- df 
write_rds(youth_cleaned, file = "youth_cleaned.rds")
df <- read_rds("youth_cleaned.rds")

#H===================================
## > cross tabulation 
#H===================================
table(df$fct_sex, df$fct_homeleaving)
df %>% tabyl(fct_sex, fct_homeleaving)

df %>% tabyl(fct_sex, fct_homeleaving) %>% 
  adorn_totals(c("row", "col")) %>% 
  adorn_percentages("row") %>% 
  adorn_pct_formatting(1) %>% 
  adorn_ns("front")
  
#H===================================
## > visualisation of categorical variables 
#H===================================
bar chart using ggplot 
ggplot(data = df, aes(x = fct_netcht))
ggplot(df, aes(x = fct_netcht)) + geom_bar()
df %>% ggplot(aes(x = fct_netcht)) + geom_bar()

a <- df %>% tabyl(fct_netcht)

ggplot(data = a, aes(x = fct_netcht, y = percent)) +
  geom_bar(stat = "identity")

ggplot(data = a, aes(x = fct_netcht, y = percent * 100)) +
  geom_bar(stat = "identity")

labels and themes 
ggplot(data = a, aes(x = fct_netcht, y = percent * 100)) +
  geom_bar(stat = "identity") + theme_bw()

netlabel <- labs(x = "Hours spent on social media", y = "%")

ggplot(data = a, aes(x = fct_netcht, y = percent * 100)) +
  geom_bar(stat = "identity") + theme_bw() + netlabel

#H===================================
## > produce a descriptive statistics table 
#H===================================

var <- c("age", "hlf", "fct_sex", "fct_netcht")

library(tableone)
CreateTableOne(data = df[,var])

print(CreateTableOne(data = df[, var]),
      showAllLevels = TRUE)
#H===================================
## > Your task ----
#H===================================
Read youth data. You’re primarily interested in young pupils’ 
lives residing in England. Filter out cases as necessary. Subset 
by selecting variables of your choice. Rename variables as necessary.
Produce a descriptive statistics table.

temp  <- read_dta("youth.dta")
names(temp) <- str_replace(names(temp),"yp","")
youth <- youth %>%
  select(pidp, age = dvage, sex, country, urban_dv, hsw, hap, hlf, evrsmo, lvhm, vte6, socweb, netcht, truant, argm, argf, uni, mobu)
youth[youth == -9] <- NA
youth[youth == 9] <- NA 
youth <- youth %>% filter(country == 1)

var <-c("age", "hlf", "argm", "argf")
library (tableone)
CreateTableOne(data = df[, var])

2.	Factorise vte6. Use Very interested = 1, Fairly interested = 2, 
Not interested = 3. Then, produce a univariate distribution graph 
reporting in relative frequency (percent). Interpret.

youth$fct_vte6 <- factor(youth$vte6, labels = 
                            c("very interested",
                              "fairly interested",
                              "not interested"))
youth %>% tabyl(fct_vte6, vte6)

b <- youth %>% tabyl(fct_vte6)
ggplot(data = b, aes(x = fct_vte6, y = percent * 100)) +
  geom_bar(stat = "identity")

3.	Investigate the relationship between vte6 and sex. 
is there a gender difference in interests in politics?

youth$fct_sex <- factor(youth$sex, labels = c ("male", "female"))

youth %>% tabyl(fct_sex, fct_vte6) %>% 
  adorn_totals(c("row", "col")) %>% 
  adorn_percentages("row") %>% 
  adorn_pct_formatting(1) %>% 
  adorn_ns("front")
  

  
