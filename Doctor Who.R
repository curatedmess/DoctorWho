# tidytuesday Week11-23-2021 | Doctor Who
# Data: {datardis} package by way of Jonathan Kitt

#libraries
library(tidytuesdayR)
library(tidyverse)
library(showtext)

## Add Font
font_add_google(name = "Open Sans", family = "open sans")

# turn on showtext
showtext_auto()

#load data
tuesdata <- tidytuesdayR::tt_load('2021-11-23')
episodes <- tuesdata$episodes

view(episodes)


#wrangle data
episodes%>%
  select(type,rating,episode_title,episode_number,season_number, uk_viewers)%>%
  filter(type=="episode")->data
  data <- tibble::rowid_to_column(data, "episode_id")%>%
  na.omit(rating)
  

#plot
data%>%
  ggplot(aes(x=episode_id, y=rating)) +
  geom_point(size=3, alpha=0.5) +
  geom_smooth(se=FALSE, method = , color="#2596be") +
  annotate("text", x = 76, y  =91, size=3,label="— IMDb ratings peaked at the end of Season 4.") +
  theme_minimal() +
  labs(title="Doctor Who TV Series",
       subtitle="The rise and fall of the episodes' IMDb ratings.",
       caption = "\n#tidytuesday | Data: datardis package by way of Jonathan Kitt | @ryanahart",
       x="Episodes (order by Date First Aired)",
       y="IMDb Rating") +
  theme(text = element_text(family = "open sans"),
        axis.title = element_text(size = 10),
        plot.title = element_text(face = "bold",
                                  size = 16),
        plot.subtitle = element_text(face = "bold",
                                     size = 12,
                                     color="#2596be"),
        plot.caption = element_text(hjust = 0.5,
                                    vjust=1,
                                    size = 8),
        plot.margin =  margin(15, 15, 15, 15),
        plot.background = element_rect(fill="#FFFFFF"))


#save
ggsave("Doctor Who.png", units = "in", width=10, height=6)
