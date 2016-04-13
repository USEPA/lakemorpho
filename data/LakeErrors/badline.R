x <- new("SpatialLines"
    , lines = structure(list("Lines", package = "sp"), .Names = "406")
    , bbox = structure(c(341083.295191692, 5581436.4432812, 341146.084038399, 
                         5582065.43429987), .Dim = c(2L, 2L), .Dimnames = list(c("x", 
                                                                                 "y"), c("min", "max")))
    , proj4string = new("CRS"
                        , projargs = "+proj=utm +zone=14 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0"
    )
)

xl <- readOGR(".", "ErrorLakes")

plot(xl)
plot(x,add=T,col="red")

gWithin(xl,x)