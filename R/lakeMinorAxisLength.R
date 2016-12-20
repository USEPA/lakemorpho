#' Calculate the length of the minor axis for lake
#' 
#' Minor axis length is defined as the minimum length spanning the convex hull
#' of a lake.
#' 
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#' @param pointDens Number of points to place equidistant along shoreline. The 
#'        maximum point to point distance that does not also intersect the 
#'        shoreline is used.  To total of n*(n-1)/2 comparisons is possible, but
#'        in practice is usually significant less.
#' @param addLine Boolean to determine if the selected minor axis line should be 
#'        added to the inLakeMorpho object.  Defaults to True
#' 
#' @export
#' @return This returns a numeric value indicating the length of the minor axis
#'  in the lake. Units are the same as the input data.
#' 
#' @references \href{https://en.wikipedia.org/wiki/Semi-major_and_semi-minor_axes}{Link}
#' @import sp rgeos methods
#' @importFrom sp spsample
#' @importFrom stats dist
#' @importFrom cluster ellipsoidhull
#' @examples
#' data(lakes)
#' lakeMinorAxisLength(inputLM, 50)
#' lines(inputLM$minoraxisLengthLine)

lakeMinorAxisLength <- function(inLakeMorpho, pointDens, addLine = TRUE) {
  if (class(inLakeMorpho) != "lakeMorpho") {
    stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
    stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
  }
  
  result <- NA
  lakeShorePoints <- spsample(as(inLakeMorpho$lake, "SpatialLines"), pointDens, "regular")@coords
  # chull <- gConvexHull(lakeShorePoints)
  
  # https://stackoverflow.com/questions/18278382/how-to-obtain-the-lengths-of-semi-axes-of-an-ellipse-in-r
  elpshull <- predict(cluster::ellipsoidhull(lakeShorePoints))
  elpshull.center <- matrix(colMeans((elpshull)), ncol = 2, nrow = 1)
  
  dist2center <- sqrt(rowSums((t(t(elpshull) - colMeans((elpshull))))^2))
  # max(dist2center)     ## major axis
  # min(dist2center)   ## minor axis

  myLine.min <- rbind(elpshull.center, elpshull[dist2center == min(dist2center),])
  
  myLine <- SpatialLines(list(Lines(list(Line(myLine.min)), "1")),
              proj4string = CRS(proj4string(inLakeMorpho$lake)))

  result <- max(dist2center)
  
  if (addLine) {
    myName <- deparse(substitute(inLakeMorpho))
    inLakeMorpho$minoraxisLengthLine <- NULL
    inLakeMorpho <- c(inLakeMorpho, minoraxisLengthLine = myLine)
    class(inLakeMorpho) <- "lakeMorpho"
    assign(myName, inLakeMorpho, envir = parent.frame())
  }
  return(result)
} 
