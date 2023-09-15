#' Calculate surrounding topography for lake
#'
#' This function combines all input datasets into a \code{\link{lakeMorphoClass}}.
#' As a part of this combination, the surrounding topography is also determined.
#' If no input catchments are used, it is assumed that a buffer equal to the
#' maximum in lake distance is used. If an input catchement is used, then the
#' surrounding topography is the land area represented by the  catchements that
#' intersect the lake. This function (and all of \code{lakemorpho}) expect clean
#' polygons.  No internal checking (e.g. for proper encoding of holes, etc.) is
#' done.
#'
#'
#' @param inLake a SpatialPolygons or SpatialPolygonsDataFrame representing the input lake. Required.
#' @param inElev a RasterLayer representing the elevation around the lake. Required.
#' @param inCatch Optional SpatialPolygons or SpatialPolygonsDataFrame defining the
#'                Surrounding Topography.  Default is NULL which uses a buffer equal to the
#'                maximum in lake distance.
#' @param reso Optional resolution for raster output (e.g. lake distance).
#'        Defaults to the resolution of inElev
#'
#' @import sp raster methods
#' @export
#' @return Returns an object of class 'lakemorpho' that includes the surrounding
#'         topography of the lake.
#' @examples
#' \donttest{
#' data(lakes)
#' inputLM<-lakeSurroundTopo(exampleLake,exampleElev)
#' inputLM
#' }
#' 

lakeSurroundTopo <- function(inLake, inElev = NULL, inCatch = NULL, 
                             reso = ifelse(!is.null(inElev), res(inElev)[1], 10)) {
  #coercing all to sf
  inLake <- sf::st_as_sf(inLake)
  
  if (dim(inLake)[1] > 1) {
        stop(paste(dim(inLake)[1], "polygons input. Select a single lake as input."))
  }

  #slot(inLake, "polygons") <- lapply(slot(inLake, "polygons"), checkPolygonsHoles)
  # Ignores lakes smaller that 3X3 30 m pixels
  
  if (as.numeric(sf::st_area(inLake)) <= 8100) {
      return(NULL)
  }
  tmpBuff <- sf::st_buffer(inLake, dist = 180)
  nc <- round((extent(tmpBuff)@xmax - extent(tmpBuff)@xmin)/reso)
  nr <- round((extent(tmpBuff)@ymax - extent(tmpBuff)@ymin)/reso)
  # deals with very small lakes (not sure all of these are 'real' lakes), but keeps in anyway
  if (nc <= 20 || nr <= 20) {
      reso <- 10
      nc <- round((extent(tmpBuff)@xmax - extent(tmpBuff)@xmin)/reso)
      nr <- round((extent(tmpBuff)@ymax - extent(tmpBuff)@ymin)/reso)
  }
  xmax <- extent(tmpBuff)@xmax
  ymax <- extent(tmpBuff)@ymax
  xmin <- extent(tmpBuff)@xmin
  ymin <- extent(tmpBuff)@ymin
  lakepr <- rasterize(inLake, raster(xmn = xmin, xmx = xmax, ymn = ymin, ymx = ymax,
      nrows = nr, ncols = nc, crs = CRS(sf::st_crs(inLake)$wkt)))
  lakepr2 <- lakepr
  lakepr2[is.na(lakepr2)] <- 0
  lakepr2[lakepr2 == 1] <- NA
  xLakeDist <- distance(lakepr2)
  xLakeDist <- mask(xLakeDist, lakepr)
  inLakeMaxDist <- max(raster::getValues(xLakeDist), na.rm = TRUE)  
  #conditional to make at least 100m
  if (inLakeMaxDist < 100) {
      inLakeMaxDist <- 100
  }
  if (!is.null(inCatch)) {
      inCatch <- st_as_sf(inCatch)
      xSurround <- sf::st_difference(sf::st_geometry(inCatch), sf::st_geometry(inLake))
  } else {
      xSurround <- st_sf(sf::st_difference(sf::st_geometry(sf::st_buffer(
        sf::st_geometry(inLake), dist = inLakeMaxDist)), sf::st_geometry(inLake)))
  }
  if(!is.null(inElev)){
    xElev <- mask(crop(inElev, xSurround), xSurround)
    if (any(is.na(getValues(xElev)))) {
        lakeOnEdge <- T
    } else {
        lakeOnEdge <- F
    }
  } else {
    xElev <- NULL
    lakeOnEdge <- NA
}

    return(lakeMorphoClass(inLake, xElev, xSurround, xLakeDist, lakeOnEdge))
}
