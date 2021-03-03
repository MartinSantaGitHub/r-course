# Bar Graphs
library(ggplot2)
library(dplyr)

bike <- read.csv("../data/tema7/daily-bike-rentals.csv")
bike$season <- factor(bike$season,
                      levels=c(1,2,3,4),
                      labels = c("Invierno", "Primavera", "Verano", "Otoño"))
bike$workingday <- factor(bike$workingday,
                          levels = c(0,1),
                          labels = c("Día libre", "Día de trabajo"))
bike$weathersit <- factor(bike$weathersit,
                          levels = c(1,2,3),
                          labels = c("Buen tiempo", "Día nublado", "Mal tiempo"))
bike.sum = bike %>% 
  group_by(season,workingday) %>% 
  summarize(rental=sum(cnt))

bike.sum

ggplot(bike.sum,aes(x=season,y=rental,fill=workingday,label=scales::comma(rental))) + 
  geom_bar(show.legend = T,stat = "identity") + 
  labs(title="Alquileres de bicicletas por estación y día") + 
  scale_y_continuous(labels = scales::comma) + 
  geom_text(size=3,position = position_stack(vjust=0.5))
  