auto <- read.csv("../data/tema1/auto-mpg.csv",header=TRUE,sep=",",na.strings = "", stringsAsFactors = FALSE)
names(auto)

# read.csv2 == read.csv("filename", sep = ";", dec = ",")
# sep = "\t" separador de tabulación

auto_no_header = read.csv("../data/tema1/auto-mpg-noheader.csv", header = F)
head(auto_no_header,4)

auto_no_sense = read.csv("../data/tema1/auto-mpg-noheader.csv", header = T)
head(auto_no_sense,4)

auto_custom_header <- read.csv("../data/tema1/auto-mpg-noheader.csv", 
                               header = F, 
                               col.names = c("numero","millas_por_galeon","cilindrada",
                                             "desplazamiento","caballos de potencia","peso",
                                             "aceleracion","año","modelo")
                               )
head(auto_custom_header,2)

who_from_internet <- read.csv("https://raw.githubusercontent.com/MartinSantaGitHub/r-course/master/data/tema1/WHO.csv")

# NA : is not available
# na.strings = ""