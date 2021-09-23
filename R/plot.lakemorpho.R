#' Default plotting of a lakeMorpho object
#'
#' Plots the lakeMorpho class object showing the lake, surrounding topography, and in-lake distance
#'
#' @param x input lakeMorpho class to plot
#' @param ... allows for passing of other plot parameters
#' @param dist Boolean to control plotting of in lake distance
#' @param length Boolean to control plotting of max lake length line
#' @param width Boolean to control plotting of max lake width line
#' @param fetch Boolean to control plotting of fetch lines
#' @method plot lakeMorpho
#' @import grDevices
#' @export
#' @examples
#' data(lakes)
#' plot(inputLM)
#'

plot.lakeMorpho <- function(x, dist=FALSE, length=TRUE, width=TRUE, fetch=FALSE,
                            ...) {
   
    if(!is.null(x$surround)){
      plot(x$elev, ...)
      if(dist){
        plot(x$lakeDistance,col=rainbow(10),add = TRUE,legend=FALSE)
      }
      plot(x$surround, add = TRUE)
      plot(x$lake, add = TRUE)
    } else {
      plot(x$lake,...)
    }
    if(!is.null(x$maxLengthLine)&length){plot(x$maxLengthLine,add = TRUE, col="blue")}
    if(!is.null(x$maxWidthLine)&width){plot(x$maxWidthLine,add = TRUE,col="red")}
    if(!is.null(x$majoraxisLengthLine)&width){plot(x$majoraxisLengthLine,add=TRUE,col="green")}
    if(!is.null(x$minoraxisLengthLine)&width){plot(x$minoraxisLengthLine,add=TRUE,col="orange")}
    if(fetch){
      for(i in names(x)[grep("Fetch",names(x))]){
        plot(x[[i]],add=TRUE,col="green")
      }
    }
}
