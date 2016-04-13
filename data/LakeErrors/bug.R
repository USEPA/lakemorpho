library(lakemorpho)
library(rgdal)
x <- readOGR(".", "ErrorLakes")
x1 <- lakeMorphoClass(x[1,],NULL,NULL,NULL)
for(i in 1:100){
  cat ("Press [enter] to continue, q to quit")
  line <- readline()
  if(line == "q"){break()}
  xl <- lakeMaxLength(x1,50)
  plot(x1$lake)
  plot(x1$maxLengthLine,add=T,col="blue",lwd=3)
  #plot(x1$maxWidthLine,add=T,col="red",lwd=3)
}
