# MongoDB
#install.packages("mongolite")

library(data.table)
library(RMongo)
library(mongolite)
library(dplyr)
library(ggplot2)
library(maps)
library(ggmap)

crimes = data.table::fread("../data/tema13/Chicago_Crimes_2012_to_2017.csv")

# Funciones de mongo lite
crime_collection = mongo(collection = "fullcrimes",
                         db = "Chicago")

crime_collection$insert(crimes)

crime_collection$count()
crime_collection$iterate()$one()

# Funciones de RMongo
mongo <- mongo.create(host = "localhost")
mongo.is.connected(mongo)
mongo.get.database.collections(mongo, "Chicago")
mongo.find.one(mongo, ns = "Chicago.crimes")

# Mongo Lite
crime_collection$count('{"Primary Type": "ASSAULT"}')

crimes.c <- crime_collection$find('{}',fields = '{"Primary Type": 1, "Year": 1}')

crimes.c %>% 
  group_by(`Primary Type`) %>% 
  summarize(Count=n()) %>% 
  arrange(desc(Count)) %>% 
  head(10)

crimes %>% group_by(Year) %>% 
  summarize(Count=n()) %>% 
  arrange(desc(Count))

crime_collection$aggregate('[{"$group":{"_id":"$Location Description", "Count":{"$sum":1}}}]') %>% 
  na.omit() %>%
  arrange(desc(Count)) %>%
  head(10) %>%
  ggplot(aes(x=reorder(`_id`, Count), y = Count)) +
  geom_bar(stat = "identity", fill="#C678EF") +
  geom_text(aes(label = Count), color = "red") +
  coord_flip() + xlab("Lugar del crimen") + ylab("Número de crímenes")

query <- crime_collection$find('{}', '{"_id":0, "Latitude":1, "Longitude":1, "Year":1}')
counts <- as.data.frame(table(round(query$Longitude, 2), round(query$Latitude,2)))

counts$Long <- as.numeric(as.character(counts$Var1))
counts$Lat <- as.numeric(as.character(counts$Var2))
counts$Var1 <- NULL
counts$Var2 <- NULL

#register_google(key = "insert key here")
chicago <- get_map(location = "chicago",zoom = 11)

ggmap(chicago) +
  geom_tile(data=counts, aes(x=Long, y = Lat, alpha = Freq), fill = "red") +
  ggtitle("Distribución de Crímenes entre 2012 y 2017 en Chicago") +
  labs(alpha="Número de crímenes") + 
  theme(plot.title = element_text(color = "red", hjust = 0.5))
