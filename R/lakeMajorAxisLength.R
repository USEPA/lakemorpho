#' Calculate the length of the major axis for lake
#' 
#' Major axis length is defined as the maximum length spanning the convex hull
#' of a lake.
#' 
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#' @param addLine Boolean to determine if the selected major axis line should be 
#'        added to the inLakeMorpho object.  Defaults to True
#' 
#' @export
#' @return This returns a numeric value indicating the length of the major axis
#'  in the lake. Units are the same as the input data.
#' @encoding UTF-8
#' @references \href{https://en.wikipedia.org/wiki/Semi-major_and_semi-minor_axes}{Wikipedia}
#' 
#' Kirillin, G., Engelhardt, C., Golosov, S. and Hintze, T., 2009. Basin-scale
#' internal waves in the bottom boundary layer of ice-covered Lake Müggelsee,
#' Germany. Aquatic ecology, 43(3), pp.641-651.
#' 
#' @importFrom rgeos gLength
#' @importFrom cluster ellipsoidhull
#' @examples
#' \dontrun{
#' data(lakes)
#' lakeMajorAxisLength(inputLM)
#' plot(inputLM$lake)
#' lines(inputLM$majoraxisLengthLine)
#' }

lakeMajorAxisLength <- function(inLakeMorpho, addLine = TRUE) {

  if (class(inLakeMorpho) != "lakeMorpho") {
    stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
  }
  
  result <- NA
  lakeShorePoints <- as(as(inLakeMorpho$lake, "SpatialLines"),
                        "SpatialPoints")@coords
  
  # https://stackoverflow.com/questions/18278382/how-to-obtain-the-lengths-of-semi-axes-of-an-ellipse-in-r
  elpshull <- predict(cluster::ellipsoidhull(lakeShorePoints))
  elpshull.center <- matrix(colMeans((elpshull)), ncol = 2, nrow = 1)
  
  dist2center <- sqrt(rowSums((t(t(elpshull) - colMeans((elpshull))))^2))

  myLine.max <- elpshull[dist2center == max(dist2center),]
  myLine <- sp::SpatialLines(list(Lines(list(Line(myLine.max)), "1")),
              proj4string = sp::CRS(sp::proj4string(inLakeMorpho$lake)))

  result <- rgeos::gLength(myLine)
  
  if (addLine) {
    myName <- deparse(substitute(inLakeMorpho))
    inLakeMorpho$majoraxisLengthLine <- NULL
    inLakeMorpho <- c(inLakeMorpho, majoraxisLengthLine = myLine)
    class(inLakeMorpho) <- "lakeMorpho"
    assign(myName, inLakeMorpho, envir = parent.frame())
  }
  return(result)
} 
