#' Function to calculate fetch along an input bearing
#' 
#' The function calculates the maximum in lake distance of a line along an input
#' bearing.
#' 
#' @param inLakeMorpho An object of \code{\link{lakeMorphoClass}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#' @param bearing Numeric that indicates the bearing of the desired fetch 
#' @param addLine Boolean to determine if the selected max length line should be 
#'        added to the inLakeMorpho object.  Defaults to True.  Note that the 
#'        line is returned in the same projection as the input data.  
#' @export
#' @return Returns a numeric value indicating the length of the longest 
#'         line in the lake along the input bearing. Units are the same as the 
#'         input data.
#' 
#' @references Florida LAKEWATCH (2001). A Beginner's guide to water management
#'             - Lake Morphometry (2nd ed.). Gainesville: Florida LAKEWATCH, 
#'             Department of Fisheries and Aquatic Sciences.
#'             \href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
#' 
#' @import geosphere methods
#' @importFrom sf st_cast st_centroid st_as_sf st_transform st_crs st_bbox st_coordinates st_linestring st_sfc st_length st_within st_intersection st_sf st_geometry
#' 
#' @export
#' 
#' @examples
#' library(sf)
#' data(lakes)
#' lakeFetch(inputLM,45)

lakeFetch <- function(inLakeMorpho, bearing, addLine = TRUE) {
  
  inputName <- deparse(substitute(inLakeMorpho))
  if (!inherits(inLakeMorpho, "lakeMorpho")) {
    stop("Input data is not of class 'lakeMorpho'.  Run lakeSurround Topo or lakeMorphoClass first.")
  }
  result <- NA
  
  # convert to dd
  lakedd <- sf::st_transform(sf::st_as_sf(inLakeMorpho$lake), crs = sf::st_crs("+proj=longlat +datum=WGS84"))
  
  # get min/max distance: converts original extent to square.  ensures full coverage of possible lines
  lakedd_bbox <- st_bbox(lakedd)
  origMinMin <- t(matrix(c(lakedd_bbox["xmin"], lakedd_bbox["ymin"])))
  origMaxMax <- t(matrix(c(lakedd_bbox["xmax"], lakedd_bbox["ymax"])))
  origMinMax <- t(matrix(c(lakedd_bbox["xmin"], lakedd_bbox["ymax"])))
  origMaxMin <- t(matrix(c(lakedd_bbox["xmax"], lakedd_bbox["ymin"])))
  
  # Get distances for each side of bounding box
  l1 <- distCosine(origMinMin, origMaxMin)
  l2 <- distCosine(origMinMin, origMinMax)
  # get new points to make the extent square
  if (l1 > l2) {
    minPt <- t(matrix(destPoint(origMinMin, 180, (l1 - l2) / 2)))
    maxPt <- t(matrix(destPoint(origMaxMax, 0, (l1 - l2) / 2)))
  } else {
    minPt <- t(matrix(destPoint(origMinMin, 270, (l2 - l1) / 2)))
    maxPt <- t(matrix(destPoint(origMaxMax, 90, (l2 - l1)/2)))
  }
  maxDist <- distCosine(minPt, maxPt)
  
  # Convert bearing to half
  if (bearing > 180) {
    bearing <- bearing - 180
  }
  # calc perpendicular bearings
  if (bearing < 90) {
    perpbear1 <- bearing + 90
    perpbear2 <- perpbear1 + 180
  } else {
    perpbear1 <- bearing - 90
    perpbear2 <- perpbear1 + 180
  }
  
  # Build list of center points for perpbear1
  centPts <- list()
  # needs centroid, not all coords
  # Slight difference with original which returned the label point which is
  # kinda the centroid...
  centPts[[1]] <- data.frame(st_coordinates(sf::st_centroid(sf::st_geometry(lakedd))))
  names(centPts[[1]]) <- c("lon", "lat")
  centPts[[2]] <- destPoint(as.matrix(centPts[[1]]), perpbear1, 100)
  i <- length(centPts)
  while (any(centPts[[i]][, 1] < maxPt[, 1] &
             centPts[[i]][, 1] > minPt[, 1] &
             centPts[[i]][, 2] < maxPt[, 2] &
             centPts[[i]][, 2] > minPt[, 2])) {
    i <- length(centPts) + 1
    centPts[[i]] <- destPoint(centPts[[i - 1]], perpbear1, 100)
  }
  
  # Build list of center points for perpbear2
  i <- length(centPts) + 1
  centPts[[i]] <- destPoint(as.matrix(centPts[[1]]), perpbear2, 100)
  while (any(centPts[[i]][, 1] < coordinates(maxPt)[, 1] &
             centPts[[i]][, 1] > coordinates(minPt)[, 1] &
             centPts[[i]][, 2] < coordinates(maxPt)[, 2] &
             centPts[[i]][, 2] > coordinates(minPt)[, 2])) {
    i <- length(centPts) + 1
    centPts[[i]] <- destPoint(centPts[[i - 1]], perpbear2, 100)
  }
  
  # calc point for centroid, max distance, bearing + 180 (if bearing is less that 180) or - 180 (if bearing
  # is more than 180)
  allLines <- list()
  for (i in 1:length(centPts)) {
    allLines[[i]] <- sf::st_linestring(
      rbind(destPoint(centPts[[i]], bearing, maxDist),
            destPoint(centPts[[i]], bearing + 180, maxDist))
    )
  }
  allLinesSL <- st_sfc(geometry = allLines, crs = st_crs("+proj=longlat +datum=WGS84"))
  # clip out lines that are inside lake
  lakeLinesSL <- sf::st_intersection(allLinesSL, lakedd)
  lakeLinesSL_proj <- sf::st_transform(lakeLinesSL, st_crs(inLakeMorpho$lake))
  
  # Determine the longest
  lakeLinesSL_proj <- sf::st_as_sf(sf::st_cast(sf::st_cast(lakeLinesSL_proj, "MULTILINESTRING"),"LINESTRING"))
  
  result <- max(st_length(lakeLinesSL_proj))
  if(capabilities("long.double")) {
    myLine <- lakeLinesSL_proj[
      st_length(lakeLinesSL_proj, byid = TRUE) == result, ]
  } else {
    myLine <- lakeLinesSL_proj[round(as.numeric(
      st_length(lakeLinesSL_proj, byid = TRUE)),8) == round(as.numeric(result), 8), ]
  }
  
  # line added to input lakemorpho
  if (addLine) {
    myName <- paste("maxFetchLine_", bearing, sep = "")
    inLakeMorpho[[substitute(myName)]] <- NULL
    inLakeMorpho[[substitute(myName)]] <- as(myLine, "Spatial") #TODO: Yank this as() when switch to sf complete
    class(inLakeMorpho) <- "lakeMorpho"
    assign(inputName, inLakeMorpho, envir = parent.frame())
  }
  return(round(as.numeric(result),4))
}
