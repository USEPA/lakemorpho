#' Calculate the length of the minor axis for lake
#' 
#' Minor axis length is defined as the minimum length spanning the convex hull
#' of a lake.
#' 
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#' @param addLine Boolean to determine if the selected minor axis line should be 
#'        added to the inLakeMorpho object.  Defaults to True
#' 
#' @export
#' @return This returns a numeric value indicating the length of the minor axis
#'  in the lake. Units are the same as the input data.
#' 
#' @references \href{https://en.wikipedia.org/wiki/Semi-major_and_semi-minor_axes}{Wikipedia}
#' @importFrom sp proj4string CRS SpatialLines
#' @importFrom cluster ellipsoidhull
#' @examples
#' 
#' data(lakes)
#' lakeMinorAxisLength(inputLM)
#' 

lakeMinorAxisLength <- function(inLakeMorpho, addLine = TRUE) {

  if (class(inLakeMorpho) != "lakeMorpho") {
    stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
  }
  
  result <- NA
  lakeShoreLine <- as(inLakeMorpho$lake, "SpatialLines")
  lakeShorePoints <- as(lakeShoreLine, "SpatialPoints")
  lakeShoreCoords <- coordinates(lakeShorePoints)
  
  # https://stackoverflow.com/questions/18278382/how-to-obtain-the-lengths-of-semi-axes-of-an-ellipse-in-r
  elpshull <- predict(cluster::ellipsoidhull(lakeShoreCoords))
  elpshull.center <- matrix(colMeans((elpshull)), ncol = 2, nrow = 1)
  
  dist2center <- sqrt(rowSums((t(t(elpshull) - colMeans((elpshull))))^2))
  
  if(capabilities("long.double")){
    myLine.min <- rbind(elpshull.center, elpshull[dist2center == min(dist2center),])
  } else {
    myLine.min <- rbind(elpshull.center, elpshull[round(dist2center,8) == round(min(dist2center),8),])
  }
  
  
  myLine <- sp::SpatialLines(list(Lines(list(Line(myLine.min)), "1")),
              proj4string = sp::CRS(sp::proj4string(inLakeMorpho$lake)))

  result <- rgeos::gLength(myLine)
  
  if (addLine) {
    myName <- deparse(substitute(inLakeMorpho))
    inLakeMorpho$minoraxisLengthLine <- NULL
    inLakeMorpho <- c(inLakeMorpho, minoraxisLengthLine = myLine)
    class(inLakeMorpho) <- "lakeMorpho"
    assign(myName, inLakeMorpho, envir = parent.frame())
  }
  return(round(result,4))
} 
