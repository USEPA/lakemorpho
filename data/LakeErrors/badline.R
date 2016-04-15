library(quickmapr)
library(lakemorpho)
library(rgdal)
library(rgeos)
x <- structure(list(`693` = list(structure(c(341329.641389457, 341368.194230847, 
                                             5582028.28651484, 5581579.69423085), .Dim = c(2L, 2L)))), .Names = "693")
xl <- readOGR("data/LakeErrors", "ErrorLakes")[1,]
x<-SpatialLines(list(Lines(list(Line(coordinates(x))),ID=1)),proj4string = CRS(proj4string(xl)))

plot(xl)
plot(x,add=T,col="red")

gWithin(xl,x,byid = T)

#Recreating line and it returns false... Whoa!