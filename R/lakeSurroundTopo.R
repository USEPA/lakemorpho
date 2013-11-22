#' Calculate surrounding topography for lake
#' 
#' This function combines all input datasets into a \code{\link{lakeMorphoClass}}.
#' As a part of this combination, the surrounding topography is also determined.
#' If no input catchements are used, it is assumed that a buffer equal to the
#' maximum in lake distance is used. If an input catchement is used, then the 
#' surrounding topography is the land area represented by the  catchements that 
#' intersect the lake. 
#' 
#' 
#' @param inLake a SpatialPolygons representing the input lake
#' @param inElev a RasterLayer representing the elevation around the lake
#' @param inCatch Optional defualt is NULL wich uses a buffer equal to the
#'        maximum in lake distance.  
#' @param reso Optional resolution for raster output (e.g. lake distance).  
#'        Defaults to the resolution of inElev
#'          
#' @export
#' @return lakeMorphoClass

# function to select out elevation, catchements, etc. TO DO:

# fix lake on edge

lakeSurroundTopo <- function(inLake, inElev, inCatch = NULL, reso = res(inElev)[1]) {
    lakeOnEdge = F
    slot(inLake, "polygons") <- lapply(slot(inLake, "polygons"), checkPolygonsHoles)
    # Ignores lakes smaller that 3X3 30 m pixels
    if (gArea(inLake) <= 8100) {
        return(NULL)
    }
    tmpBuff <- gBuffer(inLake, width = 180)
    nc <- round((extent(tmpBuff)@xmax - extent(tmpBuff)@xmin)/reso)
    nr <- round((extent(tmpBuff)@ymax - extent(tmpBuff)@ymin)/reso)
    # deals with very small lakes (not sure all of these are 'real' lakes), but keeps in
    # anyway
    if (nc <= 20 || nr <= 20) {
        reso <- 10
        nc <- round((extent(tmpBuff)@xmax - extent(tmpBuff)@xmin)/reso)
        nr <- round((extent(tmpBuff)@ymax - extent(tmpBuff)@ymin)/reso)
    }
    xmax <- extent(tmpBuff)@xmax
    ymax <- extent(tmpBuff)@ymax
    xmin <- extent(tmpBuff)@xmin
    ymin <- extent(tmpBuff)@ymin
    lakepr <- rasterize(SpatialPolygons(inLake@polygons), raster(xmn = xmin, xmx = xmax, 
        ymn = ymin, ymx = ymax, nrows = nr, ncols = nc, crs = CRS(proj4string(inLake))))
    lakepr2 <- lakepr
    lakepr2[is.na(lakepr2)] <- 0
    lakepr2[lakepr2 == 1] <- NA
    xLakeDist <- mask(distance(lakepr2), lakepr)
    inLakeMaxDist <- max(xLakeDist@data@values, na.rm = T)  #conditional to make at least 100m
    if (inLakeMaxDist < 100) {
        inLakeMaxDist <- 100
    }
    xBuffer <- gDifference(gBuffer(inLake, width = inLakeMaxDist), inLake)
    if (!is.null(inCatch)) {
        ind <- gOverlaps(inLake, inCatch, T)
        xCatch <- inCatch[ind[, 1], ]
        xSurround <- gIntersection(xCatch, xBuffer, T)
    } else {
        xSurround <- xBuffer
    }
    
    # Grabs needed elevation data
    bboxPoints <- rbind(bbox(xSurround)[, 1], bbox(xSurround)[, 2])
    bboxPoints <- SpatialPoints(bboxPoints, CRS(proj4string(xSurround)))
    bboxPointsGeo <- spTransform(bboxPoints, CRS("+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs"))
    corners <- abs(trunc(coordinates(bboxPointsGeo))) + 1
    
    if (is.null(intersect(extent(inElev), extent(xSurround))) == F) {
        outputR <- raster(extent(xSurround), ncols = round((extent(xSurround)@xmax - 
            extent(xSurround)@xmin)/res(inElev)[1]), nrows = round((extent(xSurround)@ymax - 
            extent(xSurround)@ymin)/res(inElev)[1]), crs = CRS(proj4string(xSurround)))
        xElev <- resample(inElev, outputR)
        xElev2 <- resample(mask(crop(inElev, xSurround), xSurround), outputR)
        xElev <- merge(xElev, xElev2)
    } else {
        xElev <- mask(crop(inElev, xSurround), xSurround)
    }
    if (is.null(intersect(extent(inElev), extent(xSurround))) == F) {
        lakeOnEdge <- T
    }
    return(lakeMorphoClass(inLake, xElev, xSurround, xLakeDist, lakeOnEdge))
} 