
# ========= What is cat("") ? =========
# It is just to highlight some words in colour.
# Otherwise, it'll be treated as comment.
# If you have an important step to highlight,
# cat(" ") is a good way, as it separates out from
# the usual comments, displayed in distinctive colour.

#H--------------------------------------------
## > Learning outcomes: ----
#H--------------------------------------------
cat("
  By the end of the session, students are able to :
    - Understand and use structure of ggplot
    - Use aes to specify x-axis and y-axis variables
    - Choose appropriate graph types among
        Histogram     : geom_histogram(),
        Boxplot       : geom_boxplot(),
        Bar chart     : geom_bar(),
        Scatterplot   : geom_point()
    - Use facet_wrap to investigate
      bivariate distributions
    - Save dataset, Combine and save images
")

#H--------------------------------------------
## > Shortcuts ----
#H--------------------------------------------
      # Clean Console : Ctrl + L
      # Type %>%      : Ctrl + Shift + M

      # Type <-       : Alt  + -
      # (Un)Comment   : Ctrl + /
      # Help example  : ?select

#H--------------------------------------------
## > Prep:  ----
#H--------------------------------------------
getwd()# Check your current path
getwd()
rm(list = ls())    # Remove objects
rm(list = ls())

setwd("P:/R_AST")

# install.packages("gridExtra") # Combine graphs
install.packages("gridExtra")
# Load packages (MUST LOAD EVERY SESSION!)
library("haven")      # To read .dta data file
library("haven")
library("tidyverse")  # data manipulation
library("tidyverse")
library("ggplot2")    # grapahics
library("ggplot2")
library("gridExtra")  # Combine graphs
library("gridExtra")
library("janitor")    # cross-tabulation
library("janitor")
library("tableone")   # Desc stats
library("tableone")
library("psych")      # descriptive statistics
library("psych")

theme_set(theme_bw()) # set grapahics theme
theme_set(theme_bw())

# YOUR CODE STARTS HERE
#H===================================
## > birthweight data ----
#H===================================
b  <- read.csv("babies_25vars.csv")
b  <- read.csv("babies_25vars.csv")

b <- b %>% mutate(low_bwt = ifelse(bkg < 2.5, 1, 2))
b %>% tabyl(low_bwt)
b$fct_lowbwt <- factor(b$low_bwt,
                labels = c("yes", "no"))
b %>% tabyl(fct_lowbwt, low_bwt)

prac <- b %>% mutate(low_bwt = ifelse(bkg > 2.5, 0, 1))
prac %>% tabyl(low_bwt)

#H===================================
## > Treat outliers 
#H===================================
hist(b$age)
boxplot(b$age)
summary(b$age)
sd(b$age)
describe(b$age, fast = TRUE)
bb <- b %>% filter(age < 48)
describe (bb$age, fast = TRUE)
boxplot(bb$age)

#H===================================
## > Select idenity variable types 
#H===================================
baby <- bb %>% 
  select(id, bkg, age, height, weight, starts_with("fct"))

write_rds(baby, file = "baby_cleaned.rds")

baby <- read_rds("baby_cleaned.rds")

babydesc <- baby %>% select(-id)
print(CreateTableOne(data = babydesc), showAllLevels = TRUE)

#H===================================
## > Group summary statistics 
#H===================================
describe(babydesc[, 1:4], fast = TRUE)
describeBy(babydesc$bkg, babydesc$fct_smoke, fast = TRUE)

#H===================================
## > A. Visualising Continuous var:
#H===================================
#H===================================
## > Histogram 
#H===================================
ggplot(data = baby, aes(x = bkg)) + geom_histogram()
ggplot(data = baby, aes(x = bkg)) + geom_histogram(binwidth = 0.2)
ggplot(data = baby, aes(x = bkg)) + geom_histogram(binwidth = 1)
ggplot(data = baby, aes(x = bkg)) + geom_histogram(binwidth = 0.2,
                                                   fill = "steelblue")
ggplot(data = baby, aes(x = bkg)) + geom_histogram(binwidth = 0.2,
                                                   colour = "steelblue")

ggplot(data = baby, aes(x = bkg, fill = fct_lowbwt)) + 
  geom_histogram()

ggplot(data = baby, aes(x = bkg, fill = fct_lowbwt)) + 
  geom_histogram(binwidth = 0.2)

ggplot(baby, aes(x = bkg, fill = fct_lowbwt)) + 
  geom_histogram(binwidth = 0.2) +
  facet_wrap (~fct_lowbwt)

#H===================================
## > Denisty plot 
#H===================================
ggplot(baby, aes(x = bkg)) +
  geom_density()

ggplot(data = baby, aes(x = bkg, fill = fct_lowbwt)) + 
  geom_density()

d1  <- ggplot(baby, aes(x = bkg, fill = fct_lowbwt)) +
  geom_density()
d2 <- ggplot(baby, aes(x = bkg, fill = fct_lowbwt, alpha = 0.2)) +
  geom_density()

grid.arrange(d1, d2, ncol = 2, nrow = 1)

facet_wrap(~fct_smoke)

ggplot(baby, aes(x = bkg, fill = fct_lowbwt, alpha = 0.2)) +
  geom_density() +
  facet_wrap(~fct_smoke) + guides(alpha = "none")

#H===================================
## > Boxplot
#H===================================
ggplot(data = baby, aes(y = bkg)) +
  geom_boxplot()

ggplot(data = baby, aes(x = fct_smoke, y = bkg)) +
  geom_boxplot()

ggplot(data = baby, aes(x = fct_smoke, y = bkg, fill = fct_smoke)) +
  geom_boxplot()

#H===================================
## > Scatterplot
#H===================================
ggplot(data = baby, aes(x = age, y = bkg)) +
  geom_point()

ggplot(data = baby, aes(x = age, y = bkg)) +
  geom_point(position = "jitter")

ggplot(data = baby, aes(x = age, y = bkg, colour = fct_smoke)) +
  geom_point(position = "jitter")

ggplot(data = baby, aes(x = age, y = bkg, colour = fct_smoke)) +
  geom_point(position = "jitter", alpha = 0.8) + 
  scale_colour_manual(values = c("steelblue", "red"))

ggplot(data = baby, aes(x = age, y = bkg, shape = fct_smoke)) +
  geom_point(position = "jitter")

ggplot(data = baby, aes(x = age, y = bkg, shape = fct_smoke, colour = fct_smoke)) +
  geom_point(position = "jitter")

ggplot(data = baby, aes(x = age, y = bkg)) + 
  geom_point(position = "jitter") +
  facet_wrap(~fct_smoke)

ggplot(data = baby, aes(x = age, y = bkg)) + 
  geom_point(position = "jitter") +
  facet_grid(fct_lowbwt~fct_smoke)

#H===================================
## > B. Visualising Categorical var
#H===================================
a <- baby %>% tabyl(fct_lowbwt)

p1 <- ggplot(data = a, aes(x = fct_lowbwt, y = percent*100)) +
  geom_bar(stat = "identity")

#H===================================
## > Clustered barchart 
#H===================================
aaa <- baby %>% 
  group_by (fct_lowbwt, fct_smoke) %>% 
  summarise(count = n()) %>% 
  mutate(perc = (count/sum(count))*100)

ggplot(aaa, 
  aes(x = fct_lowbwt, y = perc, fill = fct_smoke)) +
  geom_bar(stat = "identity",position = "dodge")

ggplot(aaa, 
       aes(x = fct_lowbwt, y = perc, fill = fct_smoke)) +
  geom_bar(stat = "identity",position = "dodge",
           width = 0.6) +
  labs(x = "Low birthweight", y = "percent",
       fill = "Smoking status")

lab1 <- labs(x = "low birthweight", y = "percent", 
             fill = element_blank())

#H===================================
## > Stacked barchart 
#H===================================
lab1 <- labs(x = "low birthweight", y = "Percent",
             fill = element_blank())

ggplot(aaa,
       aes(x = fct_lowbwt, y = perc, fill = fct_smoke)) +
       geom_bar(stat = "identity") + lab1 
  
stack1 <- ggplot(aaa,
       aes(x = fct_lowbwt, y = perc, fill = fct_smoke)) +
       geom_bar(stat = "identity") + 
       scale_fill_grey() + lab1 

#H===================================
## > Save plots
#H===================================
ggsave(stack1, file = "z_stackedbar_bwt_smoke.png")

g1 <- grid.arrange(d2, stack1, ncol = 2, nrow = 1)

ggsave(g1, file = "z_combined_density_stackbar.png")

#H===================================
## > Your task
#H===================================


#H===================================
## > Extra practice 
#H===================================
a <- read_csv("OECD_emp_cleaned.csv")

head(a, n = 4)

a$f_country <- factor(a$country,levels = c("UK", "USA", "Germany", "France", "Sweden", "Japan", "China"))

#H===================================
## > Horizontal barchart 
#H===================================

oecd_lfp2 <- a %>% 
  filter(year == "2010" | year == "2022")

oecd_lfp2$f_year2 <- factor(oecd_lfp2$year,
      levels = c("2022", "2010"))

oecd_lfp2 %>% tabyl(year, f_year2)

lfplabel <- labs(x = "", y = "", 
                 title = "labour force participation rate (%) by gender during 2010 and 2022")

v4 <- oecd_lfp2 %>% 
  filter(country != "china") %>% 
  ggplot( aes(x = f_country, y = value, fill = f_year2)) +
  geom_bar (stat = "identity", position = "dodge", 
            width = 0.7) +
  facet_grid(~sex) + lfplabel +
  coord_flip() +
  scale_fill_manual(values = c("steelblue", "grey")) +
  theme(legend.position = "top") + 
  theme(legend.title = element_blank()) + lfplabel 
v4

v5 <- v4 + guides(fill = guide_legend(reverse = TRUE)) 
v5

#H===================================
## > Line graph
#H===================================
ggplot(a, aes(x = year, y = value)) + 
  geom_line(aes(colour= f_country), size = 0.6) +
  facet_wrap(~sex) + 
  geom_point(aes(shape = f_country, colour = f_country), size = 2) +
  scale_shape_manual(values=c(1, 13, 3, 16, 17 ,8 , 5)) +
  theme(legend.position = "top") +
  theme(legend.title = element_blank()) +
  labs(x = "year", y = "Labour force participation rate (%)")
