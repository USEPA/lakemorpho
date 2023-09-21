#' Function to find line representing maximum lake Width
#' 
#' Maximum lake width is defined as the maximum in lake distance that is 
#' perpendicular to the maximum lake length. As no definition specifies whether
#' or not the maximum lake width should intersect the line of maximum legnth, 
#' this function assumes that it does not, but may be forced to find the maximum 
#' width line the is perpendicular to and intersects with the maximum lake 
#' length line.  This function calculates the equation of the perpendicular line 
#' and repeats that line \code{pointDens}number of times and returns the longest 
#' of those lines.
#'
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#' @param pointDens Number of points to place equidistant along the 
#'        \code{\link{lakeMaxLength}}. A line that crosses at that point and
#'        extends from shore to shore is calcuated.
#' @param intersect Boolean to force max width to intersect the max length line.
#'        for many lakes this will return the same line.   
#' @param addLine Boolean to determine if the selected max length line should be 
#'        added to the inLakeMorpho object.  Defaults to True
#' @export
#' @return Returns a numeric value indicating the length of the longest
#'         line perpndicular to the maximum length line.
#' 
#' @references Florida LAKEWATCH (2001). A Beginner's guide to water management
#'             - Lake Morphometry (2nd ed.). Gainesville: Florida LAKEWATCH, 
#'             Department of Fisheries and Aquatic Sciences.
#'             \href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
#' @import sp methods
#' @importFrom stats var lm
#' 
#' @examples
#' library(lakemorpho)
#' data(lakes)
#' lakeMaxWidth(inputLM,25)


lakeMaxWidth <- function(inLakeMorpho, pointDens, intersect = FALSE, 
                         addLine = TRUE) {

    myName <- deparse(substitute(inLakeMorpho))
    if (!inherits(inLakeMorpho, "lakeMorpho")) {
      stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
    }
    if (is.null(inLakeMorpho$maxLengthLine)) {
        lakeMaxLength(inLakeMorpho, pointDens)
    }
    
    #linedata <- data.frame(spsample(inLakeMorpho$maxLengthLine, 30, "regular")@coords)
    linedata <- sf::st_coordinates(sf::st_sample(inLakeMorpho$maxLengthLine, 30, 
                                                 type = "regular"))
    x <- linedata[, 1]
    y <- linedata[, 2]
    xdiff <- abs(x[1] - x[2])
    ydiff <- abs(y[1] - y[2])
    lakeMinx <- sf::st_bbox(inLakeMorpho$lake)$xmin
    lakeMaxx <- sf::st_bbox(inLakeMorpho$lake)$xmax
    lakeMiny <- sf::st_bbox(inLakeMorpho$lake)$ymin
    lakeMaxy <- sf::st_bbox(inLakeMorpho$lake)$ymax
    while (!(max(x) > lakeMaxx && min(x) < lakeMinx) && !(max(y) > lakeMaxy && min(y) < lakeMiny)) {
        if (x[1] - x[2] >= 0) {
            x <- c(x, x[length(x)] - xdiff)
            x <- c(x[1] + xdiff, x)
        } else {
            x <- c(x, x[length(x)] + xdiff)
            x <- c(x[1] - xdiff, x)
        }
        if (y[1] - y[2] >= 0) {
            y <- c(y, y[length(y)] - ydiff)
            y <- c(y[1] + ydiff, y)
        } else {
            y <- c(y, y[length(y)] + ydiff)
            y <- c(y[1] - ydiff, y)
        }
    }
    longline<-data.frame(x,y)
    longline <- sf::st_linestring(as.matrix(longline))
    #longline <- SpatialLines(list(Lines(list(Line(longline)), "1")), proj4string = CRS(proj4string(inLakeMorpho$lake)))
    longlinedata <- data.frame(spsample(as(longline, "Spatial"), pointDens, "regular")@coords)
    longlinedata <- data.frame(sf::st_coordinates(sf::st_sample(longline, pointDens, 
                                                     type = "regular")))
    if (round(var(y), 1) == 0) {
        xmin <- longlinedata[, 1]
        xmax <- longlinedata[, 1]
        ypred_min <- sf::st_bbox(inLakeMorpho$lake)[2, 1]
        ypred_max <- sf::st_bbox(inLakeMorpho$lake)[2, 2]
    } else if (round(var(x), 1) == 0) {
        xmin <- sf::st_bbox(inLakeMorpho$lake)$xmin
        xmax <- sf::st_bbox(inLakeMorpho$lake)$xmax
        ypred_min <- longlinedata[, 2]
        ypred_max <- longlinedata[, 2]
    } else {
        mylm <- lm(longlinedata[, 2] ~ longlinedata[, 1])
        # Need to check this.  not getting perpendicular line...
        mylm2_slope <- (1/mylm$coefficients[2]) * -1
        mylm2_int <- (mylm2_slope * -longlinedata[, 1]) - (-longlinedata[, 2])
        xmin <- sf::st_bbox(inLakeMorpho$lake)$xmin
        xmax <- sf::st_bbox(inLakeMorpho$lake)$xmax
        ypred_min <- (mylm2_slope * xmin) + mylm2_int
        ypred_max <- (mylm2_slope * xmax) + mylm2_int
    }
    
    mydf <- data.frame(rep(xmin, length(ypred_min)), 
                       rep(xmax, length(ypred_max)), 
                       ypred_min, ypred_max)#, ID = 1:length(longlinedata[, 2]))
    mydf <- split(mydf, 1:nrow(mydf))
    #createSL <- function(x) {
    #    mat <- matrix(as.numeric(x[1:4]), 2, 2)
    #    id <- as.numeric(x[5])
    #    return(Lines(list(Line(mat)), id))
    #}
    mylinelist <- lapply(mydf, function(x) sf::st_linestring(matrix(as.numeric(x), 2, 2)))
    #mylines <- SpatialLines(mylinelist, proj4string = CRS(proj4string(inLakeMorpho$lake)))
    mylines <- sf::st_sfc(mylinelist, crs = st_crs(inLakeMorpho$lake))
    #myInter <- gIntersection(mylines[gCrosses(mylines, inLakeMorpho$lake, byid = TRUE), ], inLakeMorpho$lake, 
    #    byid = TRUE)
    myInter <- sf::st_intersection(mylines[sf::st_crosses(mylines, inLakeMorpho$lake, sparse = FALSE)], inLakeMorpho$lake)
    #lineInter <- unlist(lapply(myInter@lines, function(x) slot(x, "Lines")))
    #myInter2 <- list()
    #for (i in 1:length(lineInter)) {
    #    myInter2 <- c(myInter2, Lines(lineInter[i], i))
    #}
    #myInter2Lines <- SpatialLines(myInter2, proj4string = CRS(proj4string(inLakeMorpho$lake)))
    #if(intersect){
    #  myInter2Lines<-myInter2Lines[gIntersects(myInter2Lines,inLakeMorpho$maxLengthLine,byid = TRUE),]
    #} 
    
    if(capabilities("long.double")){
      maxWidthLine <- myInter[sf::st_length(myInter) == 
                                      max(sf::st_length(myInter))]
    } else {
      maxWidthLine <- myInter[round(sf::st_length(myInter),8) == 
                                      round(max(sf::st_length(myInter)),8)]
    }
    
    if (addLine) {
      inLakeMorpho$maxWidthLine <- NULL
      inLakeMorpho$maxWidthLine <- maxWidthLine
      class(inLakeMorpho) <- "lakeMorpho"
      assign(myName, inLakeMorpho, envir = parent.frame())
    }
    return(round(as.numeric(sf::st_length(maxWidthLine)), 4))
} 
