#' Default plotting of a lakeMorpho object
#' 
#' Plots the lakeMorpho class by showing lake, surround topography and in lake distance
#' 
#' @param x input lakeMorpho class to plot
#' @param ... allows for passing of other plot parameters
#' @method plot lakeMorpho
#' @export
#' @examples
#' \dontrun{
#' data(lakes)
#' plot(inputLM)
#' }

plot.lakeMorpho <- function(x, dist=FALSE, length=TRUE, width=TRUE, fetch=FALSE,
                            ...) {
    #browser()
    if(!is.null(x$surround)){
      plot(x$elev, ...)
      if(dist){
        plot(x$lakeDistance,col=rainbow(10),add=T,legend=FALSE)
      }
      plot(x$surround, add = T)
      plot(x$lake, add = T)
    } else {
      plot(x$lake,...)
    }
    if(!is.null(x$maxLengthLine)&length){plot(x$maxLengthLine,add = T, col="blue")}
    if(!is.null(x$maxWidthLine)&width){plot(x$maxWidthLine,add=T,col="red")}
    if(fetch){
      for(i in names(x)[grep("Fetch",names(x))]){
        plot(x[[i]],add=T,col="green")
      }
    }
}