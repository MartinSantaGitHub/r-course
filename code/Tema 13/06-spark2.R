#install.packages("sparklyr")

library(SparkR)
library(sparklyr)
library(dplyr)

sparkR.session()

# Las casas de boston y ejemplo de clasificación

df <- read.df("C:\\Repositories\\r-course\\data\\tema13\\boston-housing-logistic.csv", 
              "csv", header = "true", inferSchema = "true",
              na.strings = "NA")

showDF(df,5)

train.data <- sample(df,FALSE,0.8)
test.data <- except(df,train.data)

model <- glm(CLASS ~ NOX + DIS + RAD + TAX + PTRATIO,
             data = train.data, family = "binomial")

prediction <- predict(model,newData = test.data)
head(prediction)
showDF(prediction,6)

# Sistema de recomendación con bases de datos MySQL

#spark_install(version = "2.1.1")

#Para actualizar sparklyr una vez instalado, lo hacemos desde su GIT
#devtools::install_github("rstudio/sparklyr")

config <- spark_config()
config$`sparklyr.shell.driver-class-path` <- 
  "../lib/mysql-connector-java-5.1.45/mysql-connector-java-5.1.45-bin.jar"

sc <- spark_connect(master = "local",
                    version = "2.2.1",
                    config = config)

db.url <- "jdbc:mysql://localhost:3306/RecommendationSystem"
df.rates <- spark_read_jdbc(sc, "Movies_JDBC", 
                            options=list(url=db.url,
                                         user="msanta", 
                                         password="patita1975",
                                         dbtable="Rating"))

train <- sample_frac(df.rates, 0.7, replace = F)
summarise(train, count = n())

test <- anti_join(df.rates,train)
summarise(test, count = n())

model <- ml_als(test, rating_col = "rating", 
                user_col = "userID", item_col = "movieID",
                max_iter = 5, reg_param = 0.01)

summary(model)

pred <- ml_predict(model,test)
head(pred)

filter(pred, userID == 1641 & prediction > 3)
filter(pred, movieID == 12) %>% 
  summarise(rate = mean(prediction, na.rm = T), count = n())
