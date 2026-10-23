
# SESSION AIM
# 1. Download and use libraries and data to vizualise the relationship between
#    population size, life expectancy, and economic development (GDP per capita)
#    in various countries and various years
# 2. Filter and subset the data (i.e. select parts of the data to use)


# Install required libraries: 
#   1. the data (gapminder), 
#   2. a package that allows us to use R in a "tidy" way (tidyverse), and 
#   3. a graphics package (ggplot2)

install.packages("gapminder")
install.packages("tidyverse")
install.packages("ggplot2")

# Tell R we want to use these libraries
library(gapminder)
library(tidyverse)
library(ggplot2)

# let's look at the first few rows of the data
head(gapminder)

# We'll filter the data and just use some of it
#  (Can you see what this code does?)
gapminder_euro2007 <- gapminder  %>%
  filter(continent == "Europe" & year ==  2007) %>%
  mutate(pop_e6 = pop / 1000000)

# Now we can use ggplot plot the data:population with life expectancy
ggplot(gapminder_euro2007, aes(x = pop_e6, y = lifeExp)) +
  geom_point(col ="red")


# YOUR TASK
# Use ggplot to plot life expectancy with gdpPercap (GDP per capita)

# Questions
# 1. What sort of "model" might fit the relationship between life expectancy
#     and GDP per capita?
# 2. Does the pattern look the same for countries in other continents, e.g. asia?
# 3. Does the pattern look the same for years in the mid-late 20th century.

