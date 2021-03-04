#Añadir información a un objeto SP

library(maps)
library(maptools)

nj.map <- map("county", "new jersey", fill=T, plot = F)
nj.county <- sapply(strsplit(nj.map$names,","),function(x) x[2])
nj.sp <- map2SpatialPolygons(nj.map,IDs=nj.county,proj4string = CRS("+proj=longlat +ellps=WGS84"))
nj.df <- read.csv("../data/tema12/nj-county-data.csv")
rownames(nj.df) <- nj.df$name
nj.df$name <- NULL
nj.spdf <- SpatialPolygonsDataFrame(nj.sp, nj.df)

# Calculamos una nueva dimensión
pop_density <- nj.spdf@data$population/nj.spdf@data$area_sq_mi
pop_density
nj.spdf <- spCbind(nj.spdf,pop_density)
names(nj.spdf)

spplot(nj.spdf,"pop_density")
