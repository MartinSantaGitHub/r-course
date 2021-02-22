#install.packages("jsonlite")
library(jsonlite)

dat.1 = fromJSON("../data/tema1/students.json")
dat.2 <- fromJSON("../data/tema1/student-courses.json")

url <- "http://www.floatrates.com/daily/usd.json"
currencies <- fromJSON(url)

currency.eur = currencies$eur

head(dat.1,3)
dat.1$Email

dat.1[c(2,5,8),]
dat.1[,c(2,5)]

head(dat.2,3)

toJSON(auto)
