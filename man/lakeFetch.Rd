\name{lakeFetch}
\alias{lakeFetch}
\title{Function to calculate fetch along four cardinal directions}
\usage{
  lakeFetch(inLakeMorpho,
    bearing = c("N", "NE", "E", "SE"), pointDens,
    addLine = T)
}
\arguments{
  \item{inLakeMorpho}{An object of
  \code{\link{lakeMorphoClass}}.  Output of the
  \code{\link{lakeSurroundTopo}} function would be
  appropriate as input}

  \item{bearing}{Character that indicates the bearing of
  the desired fetch}

  \item{pointDens}{numeric value that determines number of
  lines along the specificed bearing for which to check the
  distance}

  \item{addLine}{Boolean to determine if the selected max
  length line should be added to the inLakeMorpho object.
  Defaults to True}
}
\value{
  numeric

  numeric
}
\description{
  The function calculates the maximum in lake distnace
}
\examples{
data(lakes)
exLake<-exampleLakes[95,]
inputLM<-lakeSurroundTopo(exLake,exampleElev)
lakeFetch(inputLM,'N',100)
}
\references{
  Florida LAKEWATCH (2001). A Beginner's guide to water
  management - Lake Morphometry (2nd ed.). Gainesville:
  Florida LAKEWATCH, Department of Fisheries and Aquatic
  Sciences.
  \href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
}

