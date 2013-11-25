#' Default printing of information included in lakeMorpho Class
print.lakeMorpho <- function() {
}

#' Default summary of information in lakeMorpho Class
summary.lakeMorpho <- function() {
}

#' Default plotting of a lakeMorpho object
#' 
#' Plots the lakeMorpho class by showing lake, surround topography and in lake distance
#' 
#' @param x input lakeMorpho class to plot
#' @param ... allows for passing of other plot parameters
#' @export
#' @examples
#' data(lakes)
#' exLake<-exampleLakes[95,]
#' inputLM<-lakeSurroundTopo(exLake,exampleElev)
#' plot(inputLM)

plot.lakeMorpho <- function(x, ...) {
    plot(x[[3]])
    plot(x[[2]], add = T)
    image(x[[4]], add = T)
    plot(x[[3]], add = T)
    plot(x[[1]], add = T, ...)
    
} 
