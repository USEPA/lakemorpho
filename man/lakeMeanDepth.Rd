\name{lakeMeanDepth}
\alias{lakeMeanDepth}
\title{Function to return lake Mean Depth}
\usage{
lakeMeanDepth(inLakeMorpho)
}
\arguments{
  \item{inLakeMorpho}{An object of
  \code{\link{lakeMorphoClass}}.  Output of the
  \code{\link{lakeSurroundTopo}} function would be
  appropriate as input}
}
\value{
numeric
}
\description{
Calculates average depth of lake as a mean of lake volume
divided by lake surface area
}
\examples{
data(lakes)
inputLM<-lakeSurroundTopo(exampleLake,exampleElev)
lakeMeanDepth(inputLM)
}
\references{
Florida LAKEWATCH (2001). A Beginner's guide to water
management - Lake Morphometry (2nd ed.). Gainesville:
Florida LAKEWATCH, Department of Fisheries and Aquatic
Sciences.
\href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
}

