

rm(list = ls())
library("tidyverse")
theme_set(theme_bw()) # set grapahics theme

# Disable scientific notation.
options(scipen = 999)

#=====================================
#> Probability and odds ratio table ----
#=====================================

p    <- seq(0, 1, by = 0.001)

failure <- 1-p
odds <- p/(1-p)

logodds <- log(p/(1-p))
odds_ch <- exp(logodds)

odds_d_by_1plus_odds  <-
            odds / (1 + odds)

tt <- data.frame(p, failure, odds, logodds,
          odds_ch, odds_d_by_1plus_odds)
p2 <- c(0, 0.001, 0.01, 0.1, 0.15, .2, .25, .3, .4, .45, .5,
  .55, .6, .7, .75, .8, .85, .9, .99, .999, 1)
p_table  <- tt %>% filter(p %in% p2)

round(p_table, digits = 4)

#                                  (SHRINK) (BALLOON UP)
#    success  failure    odds  |    logodds exp(logodds) odds/1+odds
#        p       1-p     p/1-p |               = odds       = p
# -----------------------------|   -----------------------------
# 1    0.000    1.000   0.0000 |       -Inf    0.0000      0.000
# 2    0.001    0.999   0.0010 |    -6.9068    0.0010      0.001
# 3    0.010    0.990   0.0101 |    -4.5951    0.0101      0.010
# 4    0.100    0.900   0.1111 |    -2.1972    0.1111      0.100
# 5    0.150    0.850   0.1765 |    -1.7346    0.1765      0.150
# 6    0.200    0.800   0.2500 |    -1.3863    0.2500      0.200
# 7    0.250    0.750   0.3333 |    -1.0986    0.3333      0.250
# 8    0.300    0.700   0.4286 |    -0.8473    0.4286      0.300
# 9    0.400    0.600   0.6667 |    -0.4055    0.6667      0.400
# 10   0.450    0.550   0.8182 |    -0.2007    0.8182      0.450
# -----------------------------|   ------------------------------
# 11   0.500    0.500   1.0000 |     0.0000    1.0000      0.500
# -----------------------------|   ------------------------------
# 12   0.550    0.450   1.2222 |     0.2007    1.2222      0.550
# 13   0.600    0.400   1.5000 |     0.4055    1.5000      0.600
# 14   0.700    0.300   2.3333 |     0.8473    2.3333      0.700
# 15   0.750    0.250   3.0000 |     1.0986    3.0000      0.750
# 16   0.800    0.200   4.0000 |     1.3863    4.0000      0.800
# 17   0.850    0.150   5.6667 |     1.7346    5.6667      0.850
# 18   0.900    0.100   9.0000 |     2.1972    9.0000      0.900
# 19   0.990    0.010  99.0000 |     4.5951   99.0000      0.990
# 20   0.999    0.001 999.0000 |     6.9068  999.0000      0.999
# 21   1.000    0.000      Inf |        Inf       Inf        NaN

#=====================================
#> Plot 1 ----
#=====================================

# x = Probability
plot(x = tt$p, y = tt$logodds,
     xlab = "Probability", ylab = "Log odds")
abline(v = 0.5, col = "red", lwd = 2)


# not used
# ggplot(tt, aes(x = p, y = logodds)) + geom_line(linewidth = 1) +
#  labs(x = "Probability", y = "Log odds")

#=====================================
#> Plot 2 ----
#=====================================

# x = logodds
plot(x = tt$logodds, y = tt$p, type = "l")

# in ggplot
ggplot(tt, aes(x = logodds, y = p)) + geom_line(linewidth = 1) +
 geom_vline(xintercept = 0, linetype="solid",
            color = "steelblue", linewidth = 3) +
 geom_hline(yintercept = 0.5, linetype="solid",
            color = "red", linewidth = 1) +
 scale_x_continuous(breaks = seq(-6, 6, 2)) +
 scale_y_continuous(breaks = seq(0, 1, 0.2)) +
 labs(x = "Log odds", y = "Probability")

# Reference
# https://stats.idre.ucla.edu/other/mult-pkg/faq/general/faq-how-do-i-interpret-odds-ratios-in-logistic-regression/
