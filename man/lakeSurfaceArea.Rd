\name{lakeSurfaceArea}
\alias{lakeSurfaceArea}
\title{Return lake surface area}
\usage{
  lakeSurfaceArea(inLakeMorpho)
}
\arguments{
  \item{inLakeMorpho}{an object of
  \code{\link{lakeMorpho}}.  Output of the
  \code{\link{lakeSurroundTopo}} function would be
  appropriate as input}
}
\value{
  numeric
}
\description{
  This function simply retruns the area of the lake
  SpatialPolygons that is part of the
  \code{\link{lakeMorpho}} class.
}

