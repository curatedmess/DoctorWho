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
imdb <- tuesdata$imdb

view(imdb)

#wrangle data
imdb$num <- paste(imdb$season, "-", imdb$ep_num)
imdb <- tibble::rowid_to_column(imdb,"episode_id")

#plot
imdb%>%
  ggplot(aes(x=episode_id, y=rating, color=factor(season))) +
  geom_point(size=3, alpha=0.75) +
  scale_color_manual(values=c("11"="#b62e43", "12"="#b62e43")) +
  geom_smooth(se=FALSE, color="#000000") +
  #annotate("text", x = 76, y  =91, size=3,label="— IMDb ratings peaked at the end of Season 4.") +
  theme_minimal() +
  labs(title="Doctor Who TV Series (Seasons 1-12)",
       subtitle="IMDb rating trending lower after poor ratings in Seasons 11 and 12.",
       caption = "\n#tidytuesday | Data: datardis package by way of Jonathan Kitt | @ryanahart",
       x="Episodes (order by Date First Aired)",
       y="IMDb Rating") +
  theme(text = element_text(family = "open sans"),
        axis.title = element_text(size = 10),
        plot.title = element_text(face = "bold",
                                  size = 16),
        plot.subtitle = element_text(face = "bold",
                                     size = 11,
                                     color="#b62e43"),
        plot.caption = element_text(hjust = 0.5,
                                    vjust=1,
                                    size = 8),
        legend.title = element_blank(),
        legend.position = "none",
        plot.margin =  margin(20, 20, 20, 20),
        plot.background = element_rect(fill="#FFFFFF"))


#save
ggsave("Doctor Who.png", units = "in", width=10, height=6)
