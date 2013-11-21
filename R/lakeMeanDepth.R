#' Function to return lake Mean Depth
#' 
#' Calculates average depth of lake as a mean of lake volume divided by
#' lake surface area
#' 
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#' @export      
#' @return numeric 
#' @references Florida LAKEWATCH (2001). A Beginner's guide to water management
#'             - Lake Morphometry (2nd ed.). Gainesville: Florida LAKEWATCH, 
#'             Department of Fisheries and Aquatic Sciences.
#'             \href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
#' 

# TO DO: Add test for null lake

lakeMeanDepth <- function(inLakeMorpho) {
    return(lakeVolume(inLakeMorpho)/lakeSurfaceArea(inLakeMorpho))
} 
