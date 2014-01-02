\name{lakeSurroundTopo}
\alias{lakeSurroundTopo}
\title{Calculate surrounding topography for lake}
\usage{
lakeSurroundTopo(inLake, inElev, inCatch = NULL, reso = res(inElev)[1])
}
\arguments{
  \item{inLake}{a SpatialPolygons representing the input
  lake}

  \item{inElev}{a RasterLayer representing the elevation
  around the lake}

  \item{inCatch}{Optional defualt is NULL wich uses a
  buffer equal to the maximum in lake distance.}

  \item{reso}{Optional resolution for raster output (e.g.
  lake distance).  Defaults to the resolution of inElev}
}
\value{
Returns an object of class 'lakemorpho' that includes the
surrounding topography of the lake.
}
\description{
This function combines all input datasets into a
\code{\link{lakeMorphoClass}}. As a part of this
combination, the surrounding topography is also determined.
If no input catchements are used, it is assumed that a
buffer equal to the maximum in lake distance is used. If an
input catchement is used, then the surrounding topography
is the land area represented by the catchements that
intersect the lake.
}
\examples{
data(lakes)
inputLM<-lakeSurroundTopo(exampleLake,exampleElev)
inputLM
}

