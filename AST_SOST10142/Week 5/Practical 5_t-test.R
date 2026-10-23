
#H--------------------------------------------
## > Data for this Practical  ----
#H--------------------------------------------
# European Social Survey (ESS) data

#H--------------------------------------------
## > Learning outcomes: ----
#H--------------------------------------------
cat("
  By the end of the session, students are able to :
    - Understand when to perform t-tests
    - Perform a one-sample and two sample t-tests
    - Interpret and report results
")

#H--------------------------------------------
## > Prep: ----
#H--------------------------------------------
library(tidyverse)
library(haven)
library(psych)
library(janitor)
theme_set(theme_bw())

options(scipen = 999)

#H--------------------------------------------
## >  ---- One sample mean t-test 
#H--------------------------------------------
data <- read_rds("ESS7e02_1_v2.rds")
head(data)

data %>% tabyl(wkhtotp) %>% adorn_totals()

data %>% ggplot(aes(x = country, y = wkhtotp))+
         geom_boxplot() +
         scale_y_continuous(limits=c(30,80))

describe(data$wkhtotp, fast = T)

sweden <- data %>% 
         filter(country == "SE")
describe(sweden$wkhtotp, fast = T)

t.test(sweden$wkhtotp, mu = 40)

#H--------------------------------------------
## >  ---- Two approaches: Critical value and p-value
#H--------------------------------------------
qt(0.025, df=653)
qt(0.975, df = 653)
qt(c(0.025, 0.975), df = 653)

pt(5.326999, df = 653)
2 * (1 - pt(5.326999, df = 653))

#H--------------------------------------------
## >  ---- Task 1 
#H--------------------------------------------
gb <- data %>% 
  filter(country == "GB")

describe(data$eduyrs, fast = T)

describe(gb$eduyrs,fast = T)

t.test(gb$eduyrs, mu = 14)

2 * (1 - pt(3.9042, df = 554))



#H--------------------------------------------
## >  ---- Two sample mean t-test 
#H--------------------------------------------
data %>% tabyl(gender) %>% adorn_totals()
describe(data$trstprl)
data %>% tabyl(trstprl) %>% adorn_totals()

describeBy(data$trstprl, data$gender, fast = T)

data %>% 
  drop_na(trstprl) %>% 
  group_by(gender) %>% 
  summarise(mn_trustprl = mean (trstprl),
            count_trustprl = n())

ggplot(data, aes(x = gender, y = trstprl)) + 
  geom_boxplot(colour = "black", fill = "lightblue")

ggplot(data, aes(x = trstprl, fill = gender)) +
  geom_density(bw = 1, alpha = 0.3)

t.test(trstprl ~ gender, data = data)

t.test(trstprl ~ gender, data = data, alternative = "greater")
t.test(trstprl ~ gender, data = data, alternative = "less")

#H--------------------------------------------
## >  ---- Task 2 
#H--------------------------------------------
ggplot (data, aes (x = gender, y = trstun))+
  geom_boxplot(colour = "black", fill = "lightblue")

ggplot(data, aes(x = trstun, fill = gender)) +
  geom_density(bw = 1, alpha = 0.3) 

describeBy(data$trstun, data$gender, fast = T)
data %>% 
  drop_na(trstun) %>% 
  group_by(gender) %>% 
  summarise(mn_trustun = mean(trstun),
            count_trustun = n()) 

t.test(trstun ~ gender, data = data)