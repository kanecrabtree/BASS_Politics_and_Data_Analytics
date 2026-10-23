setwd("C:/kanes stuff/uni work/year 2/semester 1/Market research/R tutorials/Week 1")
getwd()
pacman::p_load(tidyverse)
Months <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
Summer <- 6:9
Months[Summer]

Summer*3
Months[Summer*3]

mean(Summer)
Months[mean(Summer)]
Months[floor(mean(Summer))]
Months[ceiling(mean(Summer))]

store.num <- factor(c(3, 14, 21, 32, 54)) 
store.rev <- c(543, 654, 345, 678, 234)
store.visits <- c(45, 78, 32, 56, 34)
store.manager <- c("Annie", "Bert", "Carla", "Dave", "Ella")
(store.df <- data.frame(store.num, store.rev, store.visits, store.manager, stringAsFactors=F))

store.df[2,3]
store.df[2, ]
PieArea <- function(r){
  return(pi * r^2)}
PieArea(c(4.0, 4.5, 5.0, 6.0))
pi*c(4.0, 4.5, 5.0, 6.0)^2

#what is the mean and median of avg 
avg <- c(0, 0, 0, NA, 543, 654, 345, 678, 234)
mean(avg, na.rm = TRUE)
median(avg, na.rm = TRUE)

#how far from the median is annies store visits 
store.df[1,3]
store.df[ ,3]
med <- store.df[ ,3]
median(med)
#annies store is the median 

#rep() is a function used to replicate vectors 
#what is a promotion what is a situation
#what is support and whats its formula 
