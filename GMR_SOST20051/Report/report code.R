#setup
setwd("C:/kanes stuff/uni work/year 2/semester 1/Market research/report")
getwd()
library(psych)
library(dplyr)
library(lattice)
library(ggplot2)
library(tidyr)
library(scales)
library(corrplot)
library(gplots)
library(janitor)
library(cluster)
install.packages("factoextra")
library(factoextra)

#data set up
var <- cleanwithdurablespendsall %>% select(mpce, a773, rural, relig, b3q1, male, age)
rm(cleanwithdurablespendsall)
var <- var %>% 
  rename(CCTV = a773)
var <- var %>% 
  rename(HHsize = b3q1)
var <- var %>% 
  rename(sex = male)

#cleaning
var <- var %>% drop_na()

var %>% tabyl(sex)
var = var %>% 
  filter(sex!= 3)

var %>% tabyl(relig)
var$relig [var$relig == 1] <- 1
var$relig [var$relig == 2] <- 2
var$relig [var$relig == 3] <- 2
var$relig [var$relig == 4] <- 2
var$relig [var$relig == 5] <- 2
var$relig [var$relig == 6] <- 2
var$relig [var$relig == 7] <- 2
var$relig [var$relig == 9] <- 2

#descriptive statistics 
tab <- describe(var, fast = TRUE)

tab <- tab %>% 
  select(-vars) %>% 
  mutate( 
    mean = round(mean,2),
    sd = round(sd,2),
    se = round(se,4))

View (tab)

write.csv(tab, "descriptivetab.csv")

#correlation plot 
corrplot.mixed(corr=cor(var[ , c(1:7)], use ="complete.obs"),
                  upper = "ellipse", tl.pos="lt",
                  upper.col = colorpanel(50, "red", "gray60", "blue4"))

#cluester analysis 
var.summ <- function(data, groups) {
  aggregate(data , list(groups), function(x) mean(as.numeric (x)))
  }

var.k4 <- kmeans(var, centers = 4)
tab <- var.summ(var, var.k4$cluster)
write.csv(tab, "summtab.csv")

boxplot(var$mpce ~ var.k4$ cluster , ylab=" mpce", xlab=" Cluster")

clusplot(var, var.k4$cluster, color=TRUE, shade=TRUE, 
         labels=4, lines=0, main="k-means cluster plot")
