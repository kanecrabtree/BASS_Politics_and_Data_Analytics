getwd()
install.packages("pacman")
pacman::p_load(lubridate, magrittr, sjPlot, tidyverse)
file.zip <- "1.Crowdsourcing Dataset July 01, 2014 Incl.Ref Country.zip"
fb <- read_csv(file.csv[1])

glimpse(fb)

ycards <- aggregate(yellowCards ~ playerShort, sum, data = fb)
yrcards <- aggregate(yellowReds ~playerShort, sum, data = fb)
rcards <- aggregate(redCards ~ playerShort, sum, data = fb)
games <- aggregate(games ~ playerShort, sum, data = fb)

tone1 <- aggregate(rater1 ~ playerShort, mean, data = fb)
tone2 <- aggregate(rater2 ~ playerShort, mean, data = fb)

fb.wide <- list(ycards, yrcards, rcards, games, tone1, tone2) %>% 
                reduce(left_join, by = "playerShort")
glimpse(fb.wide)

fb.wide %<>%
  mutate(
    avg.tone = (rater1 + rater2)/2,
    prop.cards = (yellowCards + yellowReds + redCards)/games,
    rate = prop.cards * 100)

fb.wide %>% 
  select(avg.tone, prop.cards, rate) %>% 
  summary()

fb.wide %>% 
  ggplot() +
  geom_density(aes(rate), fill = "lightblue") +
  xlab("penalty rate (per 100 games)") +
  ylab("density") + 
  ggtitle("distribution of penalty rate")
  
model.1 <- lm(rate ~ avg.tone, data = fb.wide)
summary(model.1)

tab_model(model.1)

fb.wide %<>%
  mutate(rate2 = redCards/games * 100)
summary(fb.wide$rate2)

fb.wide %>% 
  ggplot() +
  geom_density(aes(rate2), fill = "lightblue") +
  xlab("red card rate (per 100 games)") +
  ylab("density") +
  ggtitle ("disitbrution of red card rate")

model.2 <- lm(rate2 ~ avg.tone, data = fb.wide)
summary(model.2)

tab_model(model.2)

fb.wide2 <- fb %>% 
  group_by(playerShort) %>% 
  summarise(
    country = unique(leagueCountry),
    club = unique(club),
    bday = unique(dmy(birthday)),
    age = 2013 - year(bday),
    position = unique(position),
    games = sum(games),
    victories = sum(victories),
    ties = sum(ties),
    defeats = sum(defeats),
    goals + sum(goals), 
    yellowCards = sum(yellowCards),
    yellowReds = sum(yellowReds),
    redCards = sum(redCards),
    rater1 = unique(rater1),
    rater2 = unique(rater2),
    avg.tone = (rater1 + rater2)/2,
    prop.cards = (yellowCards + yellowReds + redCards)/games,
    rate = prop.cards * 100,
    rate2 = redCards/games * 100)
  
model.3 <- lm(rate ~ games, data = fb.wide2)

tab_model(model.3)

model.4 <- lm(rate ~ victories, data = fb.wide2)

tab_model(model.4)

model.5 <- lm(rate ~ club, data = fb.wide2)

tab_model(model.5)

model.6 <- lm(rate ~ position, data = fb.wide2)

tab_model(model.6)

