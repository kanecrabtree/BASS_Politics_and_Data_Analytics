setwd("C:/kanes stuff/uni work/year 2/semester 1/Market research/formative assessment/code")
getwd()
library(dplyr)
library(lattice)
library(ggplot2)
library(tidyr)
library(scales)

var <- cleanwithdurablespendsall %>% select(mpce, a773, rural)
rm(cleanwithdurablespendsall)

my.col <- c("green3", "steelblue2")
my.pch <- c(1, 0)

plot(var$mpce + 2, var$a773 + 2,
     log = "xy",
     cex = 0.7,
     col = my.col[var$rural], 
     pch = my.pch[var$rural],
     main = "CCTV Sales By Class",
     xlab = "Mean Per Capita Expenditure",
     ylab = "CCTV Sales")

legend(x = "topright",
       legend = c("Rural", "Urban"),
       col = my.col,
       pch= my.pch,
       cex = 0.7)

#  next a bar plot showing urban rural purchasing percentage of cctv equipment 

var$rural <- recode(var$rural, '1' = "Rural", '2' = "Urban")

freq_table <- table(var$rural, var$percentage) 
percent_table <- prop.table(freq_table) * 100
percent_table

var <- var %>% drop_na()

var <- var %>% 
  mutate(percentage = a773/sum(a773))


ggplot(var, aes(x = rural, y = percentage, fill = rural)) +
  geom_bar(stat = "identity", width = 0.4) +
  scale_fill_manual(values = c("Rural" = "green3", "Urban" = "steelblue2")) +
  scale_y_continuous(labels = scales::percent, limits = c(0,1)) + 
  labs(title = "Percentage of CCTV sales amongs rural and urban demographics", x = "Category", y = "CCTV sales %", fill = "") +
  theme_minimal()
