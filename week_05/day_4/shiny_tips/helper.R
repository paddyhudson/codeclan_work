library(tidyverse)
library(shiny)
library(CodeClanData)

all_teams <- unique(olympics_overall_medals$team)

plot_medals <- function(t, s){
  olympics_overall_medals %>% 
  filter(team == t & season == s) %>% 
  ggplot() +
  aes(x = medal, y = count, fill = medal) +
  geom_col()
}
