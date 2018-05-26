#' Caluclates Lake Volume in R
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
#' @param correctFactor This a factor used by \code{\link{lakeMaxDepth}} to 
#'        correct the predicted maximum lake depth.  Defaults to 1.
#' @export
#' @return Returns a numeric value for the total volume of the lake
#' 
#' @references Hollister, J. W., W.B. Milstead (2010). Using GIS to Estimate 
#'             Lake Volume from Limited Data. Lake and Reservoir Management. 
#'             26(3)194-199.
#'             \href{https://doi.org/10.1080/07438141.2010.504321}{Link} 
#'
#' @references Florida LAKEWATCH (2001). A Beginner's guide to water management
#'             - Lake Morphometry (2nd ed.). Gainesville: Florida LAKEWATCH, 
#'             Department of Fisheries and Aquatic Sciences.
#'             \href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
#' @import raster
#' @examples
#' data(lakes)
#' lakeVolume(inputLM)

lakeVolume <- function(inLakeMorpho, zmax = NULL, correctFactor = 1) {
    if (class(inLakeMorpho) != "lakeMorpho") {
      stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
    }
    if(is.null(inLakeMorpho$elev) & is.null(zmax)){
      stop("No maximum depth provided and no elevation data included to estimate 
            maximum depth.  Provide a maximum depth or run lakeSurroundTopo 
            first with elevation included")
    }
    dmax <- max(inLakeMorpho$lakeDistance@data@values, na.rm = T)
    if(is.null(zmax)) {
      zmax <- lakeMaxDepth(inLakeMorpho, correctFactor)
    }
    lakevol <- sum((inLakeMorpho$lakeDistance@data@values * zmax/dmax) * res(inLakeMorpho$lakeDistance)[1] * 
        res(inLakeMorpho$lakeDistance)[2], na.rm = T)
    return(lakevol)
} 
