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
#'  
#' @references \href{https://en.wikipedia.org/wiki/Semi-major_and_semi-minor_axes}{Wikipedia}
#' 
#' Kirillin, G., Engelhardt, C., Golosov, S. and Hintze, T., 2009. Basin-scale
#' internal waves in the bottom boundary layer of ice-covered Lake Mueggelsee,
#' Germany. Aquatic ecology, 43(3), pp.641-651.
#' 
#' @importFrom cluster ellipsoidhull
#' @examples
#' data(lakes)
#' inputLM <- lakeSurroundTopo(exampleLake, exampleElev)
#' lakeMajorAxisLength(inputLM)


lakeMajorAxisLength <- function(inLakeMorpho, addLine = TRUE) {

  if (!inherits(inLakeMorpho, "lakeMorpho")) {
    stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
  }
  
  result <- NA
  lakeShoreLine <- sf::st_cast(inLakeMorpho$lake, "MULTILINESTRING")
  lakeShorePoints <- sf::st_cast(sf::st_geometry(lakeShoreLine), "MULTIPOINT")
  lakeShoreCoords <- sf::st_coordinates(lakeShorePoints)[,-3]
  
  # https://stackoverflow.com/questions/18278382/how-to-obtain-the-lengths-of-semi-axes-of-an-ellipse-in-r
  elpshull <- predict(cluster::ellipsoidhull(lakeShoreCoords))
  elpshull.center <- matrix(colMeans((elpshull)), ncol = 2, nrow = 1)
  
  dist2center <- sqrt(rowSums((t(t(elpshull) - colMeans((elpshull))))^2))

  if(capabilities("long.double")){
    myLine.max <- elpshull[dist2center == max(dist2center),]
  } else {
    myLine.max <- elpshull[round(dist2center,8) == round(max(dist2center),8),]
  }
  
  myLine <- st_sfc(sf::st_linestring(myLine.max), crs = sf::st_crs(inLakeMorpho$lake))

  
  result <- as.numeric(sf::st_length(myLine))
  if (addLine) {
    myName <- deparse(substitute(inLakeMorpho))
    inLakeMorpho$majoraxisLengthLine <- NULL
    inLakeMorpho$majoraxisLengthLine <- myLine
    class(inLakeMorpho) <- "lakeMorpho"
    assign(myName, inLakeMorpho, envir = parent.frame())
  }
  return(round(result,4))
} 
