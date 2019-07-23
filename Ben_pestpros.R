# load packages ----
library(tidyverse)
library(stats)
library(Cairo)


# data mgmt
data_d = read.csv(file.choose(), na = '', header = T)
data_p = read.csv(file.choose(), na = '', header = T)
data = bind_rows(data_d, data_p)


# plots by degree day ----
pd = data %>%
  mutate(color = densCols(DD50, log(CPBA + 1), colramp = colorRampPalette(rev(rainbow(10, end = 4 / 6))))) %>%
  ggplot(aes(x = DD50, y = log(CPBA + 1))) +
  geom_point(aes(col = color), alpha = .05, size = 2) +
  scale_color_identity() +
  geom_smooth(aes(color = "red")) +
  coord_cartesian(ylim = c(0, 4)) +
  labs(x = "Degree Day Accumulation", y = "Log CPB Adults") +
  ggtitle("CPB Adult counts, 2004-2015")
pd
CairoPNG("out/cpb_by_dd.png", h = 800, w = 1200); pd; dev.off()


# plots by julian day ----

## Julian days ##
pj = data %>%
  mutate(color = densCols(Julian, log(CPBA + 1), colramp = colorRampPalette(rev(rainbow(10, end = 4 / 6))))) %>%
  ggplot(aes(x = Julian, y = log(CPBA + 1))) +
  geom_point(aes(col = color), alpha=.5, size = 1) +
  scale_color_identity() +
  geom_smooth(aes(color = "red")) +
  coord_cartesian(ylim = c(0, 4), xlim = c(140, 255)) +
  labs(x = "Julian Day", y = "Log CPB adults") +
  ggtitle("Full-season CPB adult counts, Pest Pros data 2004-2015") +
  facet_wrap(~ Year) +
  theme(strip.text.x = element_text(size = 14, face = "bold"))
pj
CairoPNG("out/cpb_by_julian.png", h = 800, w = 1200); pj; dev.off()


## save for later
# pj = data %>%
#   mutate(color = densCols(Julian, log(CPBA + 1), colramp = colorRampPalette(rev(rainbow(10, end = 4 / 6))))) %>%
#   ggplot(aes(x = Julian, y = log(CPBA + 1))) +
#   geom_point(aes(col = color), alpha=.5, size = 1) +
#   scale_color_identity() +
#   geom_smooth(aes(color = "red")) +
#   coord_cartesian(ylim = c(0, 4), xlim = c(140, 255)) +
#   labs(x = "Julian Day", y = "Log CPB adults") +
#   ggtitle("Full-season CPB adult counts") +
#   annotate("text", x = 255, y = 4, label = paste("year = ", Year), hjust=1, fontface=2) +
#   annotate("text", x = 255, y = 3.8, label = paste("n = ",length(df$x)), hjust=1, fontface=2)
# pj


# counts by day of the week just for fun----

data %>%
  mutate(dayofweek = factor(
    format(Date, format = "%a"),
    levels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
  )) %>%
  group_by(Year, dayofweek) %>%
  summarise(mean = mean(CPBA, na.rm = TRUE),
            sd = sd(CPBA, na.rm = TRUE)) %>%
  ggplot(aes(x = dayofweek, y = mean)) +
  geom_bar(stat = "identity", aes(fill = dayofweek), color = "black") +
  geom_errorbar(aes(ymin = mean, ymax = mean + sd)) +
  facet_wrap(~ Year)

data %>%
  mutate(dayofweek = factor(
    format(Date, format = "%a"),
    levels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
  )) %>%
  group_by(Year, dayofweek) %>%
  summarise(total = sum(CPBA, na.rm = TRUE)) %>%
  ggplot(aes(x = dayofweek, y = total)) +
  geom_bar(stat = "identity", aes(fill = dayofweek), color = "black") +
  facet_wrap(~ Year)

data %>%
  mutate(dayofweek = factor(
    format(Date, format = "%a"),
    levels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
  )) %>%
  group_by(Year, dayofweek) %>%
  summarise(total = n()) %>%
  ggplot(aes(x = dayofweek, y = total)) +
  geom_bar(stat = "identity", aes(fill = dayofweek), color = "black") +
  facet_wrap(~ Year)
