\name{lakeShorelineDevelopment}
\alias{lakeShorelineDevelopment}
\title{Function to calculate shoreline development}
\usage{
lakeShorelineDevelopment(inLakeMorpho)
}
\arguments{
  \item{inLakeMorpho}{An object of
  \code{\link{lakeMorphoClass}}.  Output of the
  \code{\link{lakeSurroundTopo}} function would be
  appropriate as input}
}
\value{
Returns a numeric value for the shoreline development of
the lake
}
\description{
Shoreline development is a measure of the complexity of the
lake shoreline. It is simply the ratio of the shoreline
length (i.e. perimeter) to the perimeter of an equally
sized circle.
}
\examples{
data(lakes)
inputLM<-lakeSurroundTopo(exampleLake,exampleElev)
lakeShorelineDevelopment(inputLM)
}
\references{
Florida LAKEWATCH (2001). A Beginner's guide to water
management - Lake Morphometry (2nd ed.). Gainesville:
Florida LAKEWATCH, Department of Fisheries and Aquatic
Sciences.
\href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
}

