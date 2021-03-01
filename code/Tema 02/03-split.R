# split / unsplit
data <- read.csv("../data/tema2/auto-mpg.csv",stringsAsFactors = F)

carslist <- split(data,data$cylinders)
str(carslist$`3`)
str(carslist[[3]])
str(carslist[3])

names(carslist[[1]])
names(carslist$`3`)

