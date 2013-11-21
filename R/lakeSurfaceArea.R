#' Return lake surface area
#' 
#' This function simply retruns the area of the lake SpatialPolygons that is part
#' of the \code{\link{lakeMorphoClass}} class.
#' 
#' @param inLakeMorpho an object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#'          
#' @export
#' @return numeric
#' @references Florida LAKEWATCH (2001). A Beginner's guide to water management
#'             - Lake Morphometry (2nd ed.). Gainesville: Florida LAKEWATCH, 
#'             Department of Fisheries and Aquatic Sciences.
#'             \href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}

# function to return lake area of an inLakeMorpho Class TO DO: Add test for null lake
lakeSurfaceArea <- function(inLakeMorpho) {
    return(gArea(inLakeMorpho$lake))
} 
