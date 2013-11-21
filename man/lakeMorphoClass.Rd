\name{lakeMorphoClass}
\alias{lakeMorphoClass}
\title{Function to create a lakeMorpho class - this is input to all other methods}
\usage{
  lakeMorphoClass(inLake, inElev, inCatch, inLakeDist,
    lakeOnEdge = F)
}
\arguments{
  \item{inLake}{input lake SpatialPolygons object}

  \item{inElev}{input elevation model raster object}

  \item{inCatch}{input catchement SpatialPolygons object,
  can be buffer around lake}

  \item{inLakeDist}{input euclidean distance raster that
  measures distance from shore to any pixel in the lake}

  \item{lakeOnEdge}{Boolean indicating if inCatch (or lake
  Buffer) extends beyond extent of elevation data}
}
\value{
  lakeMorpho
}
\description{
  This is a helper function that creates a lakeMorpho class
  object
}
\seealso{
  lakeSurroundTopo
}

