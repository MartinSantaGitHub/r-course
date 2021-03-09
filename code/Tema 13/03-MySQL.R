#MySQL y bases de datos relacionales

#install.packages("RODBC")
#install.packages("RJDBC")

#install.packages("ROracle")
#install.packages("RMySQL")

# RODBC
library(RODBC)

odbcDataSources()

con <- odbcConnect("MySQL",
                   uid = "msanta",
                   pwd = "...")

custData <- sqlQuery(con,"select * from RecommendationSystem.Rating limit 5;")
custData

customers <- c("Juan Gabriel", "Ricardo", "Maria")
orderdate <- as.Date(c('2018-01-25', '2017-12-31', '2017-12-1'))
orderamount <- c(350, 44.65, 105.32)
orders <- data.frame(customers, orderdate, orderamount)

#sqlSave(con, orders, "RecommendationSystem.Orders", append = F)

#df <- sqlQuery(con, "select * from RecommendationSystem.Orders")
#df

# RMySQL
library(RMySQL)

con <- dbConnect(MySQL(),
                 dbname = "RecommendationSystem",
                 host = "127.0.0.1",
                 port = 3306,
                 username = "msanta",
                 password = "...")

ac <- dbReadTable(con, "Accomodation")
head(ac)

df <- dbGetQuery(con, "select * from Accomodation where title like '%chalet%'")
df

dbWriteTable(con, "Orders", orders, row.names = F)

dbReadTable(con, "Orders")

rs <- dbSendQuery(con, paste("select location, max(price)", 
                             "from Accomodation ",
                             "group by location ",
                             "order by max(price) desc"))
rs

while(!dbHasCompleted(rs)){
  print(fetch(rs,n=2)) # n = -1 para obtenerlos todos de golpe
}

dbClearResult(rs)
dbDisconnect(con)

dbListConnections(dbDriver("MySQL"))

library(RJDBC)
driver <- JDBC("com.mysql.jdbc.Driver", 
               classPath = "../../lib/mysql-connector-java-5.1.45/mysql-connector-java-5.1.45-bin.jar", "'")
con <- dbConnect(driver, "jdbc:mysql://127.0.0.1:3306/RecommendationSystem", 
                 "msanta", "patita1975", useSSL = F)

dbReadTable(con, 'Accomodation')

dbGetQuery(con, "select * from Accomodation")
