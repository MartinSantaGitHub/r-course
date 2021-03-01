#install.packages("ps")
#install.packages("glue")

library(devtools)

#devtools::install_github("kassambara/factoextra")

library(factoextra)

protein <- read.csv("../data/tema5/protein.csv")
rownames(protein) = protein$Country
protein$Country = NULL
protein.scaled = as.data.frame(scale(protein))

km <- kmeans(protein.scaled,4)
km

aggregate(protein.scaled,by=list(cluster=km$cluster),mean)

fviz_cluster(km,data=protein.scaled)

km <- kmeans(protein.scaled,5)
fviz_cluster(km,data=protein.scaled)
km

