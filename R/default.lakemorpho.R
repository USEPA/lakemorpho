#' Default printing of information included in lakeMorpho Class
print.lakeMorpho<-function(){}

#' Default summary of information in lakeMorpho Class
summary.lakeMorpho<-function(){}

#' Default plotting of a lakeMorpho object
#' @param inLakeMorpho input lakeMorpho class to plot

plot.lakeMorpho<-function(inLakeMorpho,...)
{
  plot(inLakeMorpho[[3]])
  plot(inLakeMorpho[[2]],add=T)
  image(inLakeMorpho[[4]],add=T)
  plot(inLakeMorpho[[3]],add=T)
  plot(inLakeMorpho[[1]],add=T)
}
