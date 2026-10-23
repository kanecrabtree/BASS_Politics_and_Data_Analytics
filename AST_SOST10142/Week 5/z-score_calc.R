
# z-score calculation

lvhm <- c(10, 15, 20, 25, 30, 35)
data <- data.frame(lvhm, mn = 20, sd= 3 )
data

library("tidyverse")
data <- data %>% 
        mutate(z = (lvhm - mn)/sd)
data
data <- data %>% 
  mutate( prob = pnorm(z))
              
data
# lvhm mn sd         z         prob
# 1   10 20  3 -3.333333 0.0004290603
# 2   15 20  3 -1.666667 0.0477903523
# 3   20 20  3  0.000000 0.5000000000
# 4   25 20  3  1.666667 0.9522096477
# 5   30 20  3  3.333333 0.9995709397
# 6   35 20  3  5.000000 0.9999997133