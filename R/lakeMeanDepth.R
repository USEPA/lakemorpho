#' Function to return lake Mean Depth
#' 
#' Calculates average depth of lake as a mean of lake volume divided by
#' lake surface area
#' 
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
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
#' \dontrun{
#' data(lakes)
#' lakeMeanDepth(inputLM)}


lakeMeanDepth <- function(inLakeMorpho, zmax = NULL) {
    if (class(inLakeMorpho) != "lakeMorpho") {
      stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
    }
    if(is.null(inLakeMorpho$elev) & is.null(zmax)){
      stop("No maximum depth provided and no elevation data included to estimate 
              maximum depth.  Provide a maximum depth or run lakeSurroundTopo 
              first with elevation included")
    }
    return(lakeVolume(inLakeMorpho, zmax)/lakeSurfaceArea(inLakeMorpho))
} 
