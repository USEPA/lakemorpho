#' Function to calculate shoreline development
#' 
#' Shoreline development is a measure of the complexity of the lake shoreline. 
#' It is simply the ratio of the shoreline length (i.e. perimeter) to the 
#' perimeter of an equally sized circle.
#'  
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input 
#' @export
#' @return Returns a numeric value for the shoreline development of the lake
#' @references Florida LAKEWATCH (2001). A Beginner's guide to water management
#'             - Lake Morphometry (2nd ed.). Gainesville: Florida LAKEWATCH, 
#'             Department of Fisheries and Aquatic Sciences.
#'             \href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
#' 
#' 
#' @examples
#' data(lakes)
#' lakeShorelineDevelopment(inputLM)

lakeShorelineDevelopment <- function(inLakeMorpho) {
    if (!inherits(inLakeMorpho, "lakeMorpho")) {
      stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
    }
    return(round((as.numeric(sf::st_length(sf::st_cast(inLakeMorpho$lake, "MULTILINESTRING"))))/(2 * sqrt(pi * as.numeric(sf::st_area(inLakeMorpho$lake)))), 4))
} 
