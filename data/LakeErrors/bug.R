library(lakemorpho)
library(rgdal)
x <- readOGR("data/LakeErrors", "ErrorLakes")
x1 <- lakeMorphoClass(x[2,],NULL,NULL,NULL)
for(i in 1:100){
  xl <- lakeMaxLength(x1,50)
  print(i)
  #plot(x1$maxWidthLine,add=T,col="red",lwd=3)
}
