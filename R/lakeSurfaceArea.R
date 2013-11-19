#' Return lake surface area
#' 
#' This function simply retruns the area of the lake SpatialPolygons that is part
#' of the \code{\link{lakeMorpho}} class.
#' 
#' @param inLakeMorpho an object of \code{\link{lakeMorpho}}.  Output of the 
#'        \code{\link{lakeSurroundTopo}} function would be appropriate as input
#'          
#' @export
#' @return numeric
 

#function to return lake area of an inLakeMorpho Class
#TO DO:
#Add test for null lake
lakeSurfaceArea<-function(inLakeMorpho)
{
  return(gArea(inLakeMorpho$lake))
}