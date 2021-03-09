# Machine Learning

#install.packages("BiocManager")
#install.packages("png")
#install.packages("DiagrammeR")
# install.packages("https://s3.ca-central-1.amazonaws.com/jeremiedb/share/mxnet/CPU/3.6/mxnet.zip", repos = NULL)
# repos <- getOption("repos")
# repos
# repos["mxnet"] <- "https://s3.ca-central-1.amazonaws.com/jeremiedb/share/mxnet/CPU/3.6/mxnet.zip"
# repos
# options(repos = repos)
# install.packages("mxnet")

#library(devtools)
#devtools::install_github("rich-iannone/DiagrammeR")

#library(BiocManager)
#BiocManager::install()
#BiocManager::install("EBImage")

library(mxnet)
library(png)
library(jpeg)
library(EBImage)

# if(!file.exists("../data/tema8/syntex.txt")){
#   download.file("http://data.dmlc.ml/mxnet/models/imagenet/inception-bn.tar.gz",
#                 destfile = "../data/tema8/inception-bn.tar.gz",mode = "wb",method="auto")
#   untar("../data/tema8/inception-bn.tar.gz",
#         exdir = "../data/tema8/")
#   file.remove("../data/tema8/inception-bn.tar.gz")
# }

model <- mx.model.load("../data/tema8/Inception-BN", iteration = 126)
synsets <- readLines("../data/tema8/synset.txt")
synsets

elephant <- readImage("../data/tema8/elephant.jpg")
kangaroo <- readImage("../data/tema8/kangaroo.jpg")
leopard <- readImage("../data/tema8/leopard.jpg")

head(elephant)

preproc.image <- function(image, isPng = F){
  n_channels = 3
  
  if(isPng){
    n_channels = 4
  }
  
  resized <- resize(image, 224, 224)
  arr <- as.array(resized) * 255
  dim(arr) <- c(224,224,n_channels)
  m <- mean(arr)
  print(paste("Color promedio de la imagen: ",m, sep = " "))
  norm <- arr - m
  dim(norm) = c(224,224,n_channels,1)
  #norm <- norm[,,1:3,]
  return(norm)
}

classify.image <- function(image, isPNG = F){
  image.n <- preproc.image(image, isPNG)
  prob <- predict(model, X = image.n)
  #De todas las categorías, nos quedamos el top 5 de más probables
  sorted.p <- order(prob[,1], decreasing = T)
  max.idx <- sorted.p[1:5]
  result <- data.frame(cat=synsets[max.idx], 
                       prob = 100.0*prob[sorted.p[1:5]])
  
  result
}

display(elephant)
classify.image(elephant)

display(kangaroo)
classify.image(kangaroo)

display(leopard)
classify.image(leopard)

policy <- readImage("../data/tema8/policy.jpg")
display(policy)
classify.image(policy)

donuts <- readImage("../data/tema8/donuts.jpeg")
display(donuts)
classify.image(donuts)

pen <- readImage("../data/tema8/pen.jpg")
display(pen)
classify.image(pen)

fry.pan <- readImage("../data/tema8/fry-pan.jpg")
display(fry.pan)
classify.image(fry.pan)
