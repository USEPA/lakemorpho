#' Function to return lake Mean Depth
#' 
#' Calculates average depth of lake as a mean of lake volume divided by
#' lake surface area
#' 
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#' @param slope_quant The slope quantile to use to estimate maximum depth.  
#'                    Defaults to the median as described in (Hollister et. al, 
#'                    2011).
#' @param zmax Maximum depth of the lake.  If none entered and elevation dataset
#'             is inlcuded in inLakeMorpho, \code{\link{lakeMaxDepth}} is used 
#'             to estimate a maximum depth.
#' @export      
#' @return Returns a numerica value for the mean depth of the lake 
#' @references Florida LAKEWATCH (2001). A Beginner's guide to water management
#'             - Lake Morphometry (2nd ed.). Gainesville: Florida LAKEWATCH, 
#'             Department of Fisheries and Aquatic Sciences.
#'             \href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
#' 
#' @examples
#' data(lakes)
#' lakeMeanDepth(inputLM)


lakeMeanDepth <- function(inLakeMorpho,  zmax = NULL, 
                          slope_quant = 0.5, correctFactor = 1) {
    if (class(inLakeMorpho) != "lakeMorpho") {
      stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
    }
    if(is.null(inLakeMorpho$elev) & is.null(zmax)){
      warning("No maximum depth provided and no elevation data included to estimate 
            maximum depth.  Provide a maximum depth or run lakeSurroundTopo 
            first with elevation included.  Without these, returns NA.")
      return(NA)
    }
    return(round(lakeVolume(inLakeMorpho, slope_quant = slope_quant, 
                            zmax = zmax, correctFactor = correctFactor)/
                   lakeSurfaceArea(inLakeMorpho), 4))
} 
