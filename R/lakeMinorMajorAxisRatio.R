#' Calculate the ratio of the minor axis length to major axis length
#' 
#' Major axis length is defined as the maximum length spanning the convex hull
#' of a lake. Minor axis length is defined as the minimum length spanning the
#' convex hull of a lake.
#' 
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#' @param addLine Boolean to determine if the selected major and minor axis lines
#'        should be added to the inLakeMorpho object.  Defaults to True
#' 
#' @export
#' @return This returns a vector of numeric values indicating the length of the
#'         major and minor axes of the lake. Units are the same as the input data.
#' 
#' @references \href{https://en.wikipedia.org/wiki/Semi-major_and_semi-minor_axes}{Link}
#' @importFrom rgeos gLength
#' @examples
#' \dontrun{
#' data(lakes)
#' lakeMinorMajorRatio(inputLM)
#' plot(inputLM$lake)
#' lines(inputLM$majoraxisLengthLine)
#' lines(inputLM$minoraxisLengthLine)}

lakeMinorMajorRatio <- function(inLakeMorpho, addLine = TRUE) {
  myName <- deparse(substitute(inLakeMorpho))
  if (class(inLakeMorpho) != "lakeMorpho") {
    stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
  }
  
  if (is.null(inLakeMorpho$majoraxisLengthLine) |
      is.null(inLakeMorpho$minoraxisLengthLine)) {
    lakeMinorAxisLength(inLakeMorpho)
    lakeMajorAxisLength(inLakeMorpho)
    
    assign(myName, inLakeMorpho, envir = parent.frame())
  }

  result <- rgeos::gLength(inLakeMorpho$minoraxisLengthLine) /
            rgeos::gLength(inLakeMorpho$majoraxisLengthLine)
  
  return(result)
} 
