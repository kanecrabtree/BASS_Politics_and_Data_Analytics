
# SESSION AIM ----
# 1. Download and use libraries and data to vizualise the relationship between
#    population size, life expectancy, and economic development (GDP per capita)
#    in various countries and various years
# 2. Filter and subset the data (i.e. select parts of the data to use)


# Install required libraries:  ---- 
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

# Data preparation ----
# let's look at the first few rows of the data
head(gapminder)

# We'll filter the data and just use some of it
#  (Can you see what this code does?)
gapminder_euro2007 <- gapminder  %>%
  filter(continent == "Europe" & year ==  2007) %>%
  mutate(pop_e6 = pop / 1000000)

# Plotting the data ----
# Now we can use ggplot plot the data:population with life expectancy
ggplot(gapminder_euro2007, aes(x = pop_e6, y = lifeExp)) +
  geom_point(col ="red")


# YOUR TASK ----
# Use ggplot to plot life expectancy with gdpPercap (GDP per capita)

ggplot(gapminder_euro2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(col ="red")


# Questions ----
# Q1 ---- 
# 1. What sort of "model" might fit the relationship between life expectancy
#     and GDP per capita?

# A straight line looks like it would fit well. 
# We can ask ggplot2 to plot lines, using the "geom_smooth()" command.
# A straight line can be plotted using the "method = lm" (lm = linear model)
# We also have to say that the outcome (y) variable should be a function of ("~")
#  the presumed cause (x)

ggplot(gapminder_euro2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(col ="red") +
  geom_smooth(method = lm, formula = y ~ x)

# Q2 ----
# 2. Does the pattern look the same for countries in other continents, e.g. asia?

gapminder_asia2007 <- gapminder  %>%
  filter(continent == "Asia" & year ==  2007) %>%
  mutate(pop_e6 = pop / 1000000)

ggplot(gapminder_asia2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(col ="red") +
  geom_smooth(method = lm, formula = y ~ x)

# The straight line looks like it describes the pattern of the points quite well, 
#  although there is a least one country that is far from the line, i.e. it is 
#  not well represented by the "model"

# Q3 ----
# 3. Does the pattern look the same for years in the mid-late 20th century.

# First we have to define what we mean by the "mid-late 20th century. I will
#  define this as years between 1950 and 2000, inclusive:

# Europe
gapminder_euro1950_2000 <- gapminder  %>%
  filter(continent == "Europe" & (year >=  1950 & year <= 2000)) %>%
  mutate(pop_e6 = pop / 1000000) 

ggplot(gapminder_euro1950_2000, aes(x = gdpPercap, y = lifeExp)) +
    geom_point(col ="red") +
    geom_smooth(method = lm, formula = y ~ x)

# At middle gdps a straight line seems to fit very well, but at very low and 
#  very high gdpPercap, the data do not seem to be well described by a 
#  straight line


# Asia 
gapminder_asia1950_2000 <- gapminder  %>%
  filter(continent == "Asia" & (year >=  1950 & year <= 2000)) %>%
  mutate(pop_e6 = pop / 1000000) 

ggplot(gapminder_asia1950_2000, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(col ="red") +
  geom_smooth(method = lm, formula = y ~ x)

# A straight line does not describe these data very well. 
# The slope of the line looks like it is being influenced a lot
#  by a small number of points that have much higher gdps than 
#  the rest. 



# Alternative approach - using tidyverse "pipes" ( "%>%" ) to avoid 
#  creating a new dataframe every time we want to plot a subset the data

# The commands below create a plot for African countries in 2007, without
#  needing to create a new dataframe for these data (you'll see that there 
#  is no new "Data" listed in the "Environment" tab after running these
#  commands)

gapminder  %>%
  filter(continent == "Africa" & year ==  2007) %>%
  mutate(pop_e6 = pop / 1000000) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
   geom_point(col ="red") +
   geom_smooth(method = lm, formula = y ~ x)

# Note that we only need to put a pipe ("%>%") between separate commands.
# So although the ggplot command goes across three lines of code, there is
# no need for a %>% at the end of these lines.


# The command above, but with further explanation for each line.

gapminder  %>%                                       # Take the gapminder data, and...
  filter(continent == "Africa" & year ==  2007) %>%  # ...filter out some rows, and...
  mutate(pop_e6 = pop / 1000000) %>%                 # ...mutate (change) it, and...
  ggplot(aes(x = gdpPercap, y = lifeExp)) +          # ...plot these two variables, 
  geom_point(col ="red") +                           #      as red points, 
  geom_smooth(method = lm, formula = y ~ x)          #      and as a straight line.

