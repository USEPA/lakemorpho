\name{lakeSurfaceArea}
\alias{lakeSurfaceArea}
\title{Return lake surface area}
\usage{
lakeSurfaceArea(inLakeMorpho)
}
\arguments{
  \item{inLakeMorpho}{an object of
  \code{\link{lakeMorphoClass}}.  Output of the
  \code{\link{lakeSurroundTopo}} function would be
  appropriate as input}
}
\value{
numeric
}
\description{
This function simply retruns the area of the lake
SpatialPolygons that is part of the
\code{\link{lakeMorphoClass}} class.
}
\examples{
data(lakes)
inputLM<-lakeSurroundTopo(exampleLake,exampleElev)
lakeSurfaceArea(inputLM)
}
\references{
Florida LAKEWATCH (2001). A Beginner's guide to water
management - Lake Morphometry (2nd ed.). Gainesville:
Florida LAKEWATCH, Department of Fisheries and Aquatic
Sciences.
\href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
}

