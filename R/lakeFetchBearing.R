#' Function to calculate fetch along four cardinal directions
#' 
#' The function calculates the maximum in lake distnace 
#' 
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#' @param bearing Character that indicates the bearing of the desired fetch
#' @param pointDens numeric value that determines number of lines along the 
#'        specificed bearing for which to check the distance  
#' @param addLine Boolean to determine if the selected max length line should be 
#'        added to the inLakeMorpho object.  Defaults to True
#' @export
#' @return numeric
#' 
#' @references Florida LAKEWATCH (2001). A Beginner's guide to water management
#'             - Lake Morphometry (2nd ed.). Gainesville: Florida LAKEWATCH, 
#'             Department of Fisheries and Aquatic Sciences.
#'             \href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
#' 
#' @export
#' 
#' @examples
#' data(lakes)
#' inputLM<-lakeSurroundTopo(exampleLake,exampleElev)
#' lakeFetch(inputLM,'N',100)


# Function to calculate fetch for four cardinal directions TO DO: check for null lake re-write to use an
# acutal bearing???
lakeFetch <- function(inLakeMorpho, bearing = c("N", "NE", "E", "SE"), pointDens, addLine = T) {
    if (class(inLakeMorpho) != "lakeMorpho") {
        return(warning("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo first."))
    }
    temp <- inLakeMorpho
    
    
    if (addLine) {
        myName <- paste(substitute(inLakeMorpho))
        if (bearing == "N") {
            inLakeMorpho$maxFetchLine_N <- NULL
            inLakeMorpho <- c(inLakeMorpho, maxFetchLine_N = temp$maxWidthLine)
        }
        if (bearing == "NE") {
            inLakeMorpho$maxFetchLine_NE <- NULL
            inLakeMorpho <- c(inLakeMorpho, maxFetchLine_NE = temp$maxWidthLine)
        }
        if (bearing == "E") {
            inLakeMorpho$maxFetchLine_E <- NULL
            inLakeMorpho <- c(inLakeMorpho, maxFetchLine_E = temp$maxWidthLine)
        }
        if (bearing == "SE") {
            inLakeMorpho$maxFetchLine_SE <- NULL
            inLakeMorpho <- c(inLakeMorpho, maxFetchLine_SE = temp$maxWidthLine)
        }
        class(inLakeMorpho) <- "lakeMorpho"
        assign(myName, inLakeMorpho, envir = parent.frame())
    }
    return(result)
} 
