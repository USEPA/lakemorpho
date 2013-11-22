#' Function to return lake Mean Width
#' 
#' Mean lake width is the result of lake surface area divded by the maximum 
#' length.
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
#' 
#' @examples
#' data(lakes)
#' exLake<-exampleLakes[95,]
#' inputLM<-lakeSurroundTopo(exLake,exampleElev)
#' plot(inputLM)
#' lakeMeanWidth(inputLM)
# TO DO: Add test for null lake Add test fo null maxLengthLine
lakeMeanWidth <- function(inLakeMorpho) {
    if (class(inLakeMorpho) != "lakeMorpho") {
        return(warning("Input data is not of class 'lakeMorpho'.  Run lakeSurroundTopo first."))
    }
    if (is.null(inLakeMorpho$maxLengthLine)) {
        return(warning("Input 'lakeMorpho' does not contain a Maximum Length Line.  Run lakeMaxLength  first."))
    }
    return(lakeSurfaceArea(inLakeMorpho)/gLength(inLakeMorpho$maxLengthLine))
} 
