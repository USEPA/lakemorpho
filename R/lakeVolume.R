#' Calculates Lake Volume in R
#'
#' This function returns lake volume for the input lake.  The volume is
#' calculated using maximum lake depth and maximum distance ratio to transform
#' all pixels and thus, distances, to an estimated depth.  These depths are
#' multiplied by the area of the pixel and summed.
#'
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#' @param zmax Maximum depth of the lake.  If none entered and elevation dataset
#'             is inlcuded in inLakeMorpho, \code{\link{lakeMaxDepth}} is used
#'             to estimate a maximum depth.
#' @param slope_quant The slope quantile to use to estimate maximum depth.  
#'                    Defaults to the median as described in (Hollister et. al, 
#'                    2011).
#' @param correctFactor This a factor used by \code{\link{lakeMaxDepth}} to
#'        correct the predicted maximum lake depth.  Defaults to 1.
#' @param addBathy Logical to include a depth raster on the input 
#'                  \code{\link{lakeMorphoClass}} object.  This is labelled as 
#'                  'pseudoBathy' in the output.  It is depth estimated using 
#'                  the maximum lake depth and maximum distance ratio.  Might be
#'                  useful for some applications but shouldn't be considered a 
#'                  replacement for a bathymetric survey.  
#' @export
#' @return Returns a numeric value for the total volume of the lake
#'
#' @references Hollister, J. W., W.B. Milstead (2010). Using GIS to Estimate
#'             Lake Volume from Limited Data. Lake and Reservoir Management.
#'             26(3)194-199.
#'             \doi{10.1080/07438141.2010.504321}
#'
#' @references Florida LAKEWATCH (2001). A Beginner's guide to water management
#'             - Lake Morphometry (2nd ed.). Gainesville: Florida LAKEWATCH,
#'             Department of Fisheries and Aquatic Sciences.
#'             \href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
#' @import raster
#' @examples
#' data(lakes)
#' lakeVolume(inputLM, addBathy = TRUE)

lakeVolume <- function(inLakeMorpho, zmax = NULL, slope_quant = 0.5, correctFactor = 1, 
                       addBathy = FALSE) {
  if (class(inLakeMorpho) != "lakeMorpho") {
    stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
  }
  if(is.null(inLakeMorpho$elev) & is.null(zmax)){
    warning("No maximum depth provided and no elevation data included to estimate 
            maximum depth.  Provide a maximum depth or run lakeSurroundTopo 
            first with elevation included.  Without these, returns NA.")
    return(NA)
  }
  dmax <- max(raster::getValues(inLakeMorpho$lakeDistance), na.rm = TRUE)
  if(is.null(zmax)) {
    zmax <- lakeMaxDepth(inLakeMorpho, slope_quant, correctFactor)
  }
  lakevol <- sum((raster::getValues(inLakeMorpho$lakeDistance) * zmax/dmax) * 
                   res(inLakeMorpho$lakeDistance)[1] * 
                   res(inLakeMorpho$lakeDistance)[2], na.rm = TRUE)
  
  if (addBathy) {
    myBathy <- inLakeMorpho$lakeDistance * zmax/dmax
    myName <- deparse(substitute(inLakeMorpho))
    inLakeMorpho$pseudoBathy <- NULL
    inLakeMorpho <- c(inLakeMorpho, pseudoBathy = myBathy)
    class(inLakeMorpho) <- "lakeMorpho"
    assign(myName, inLakeMorpho, envir = parent.frame())
  }
  
  return(round(lakevol, 4))
} 