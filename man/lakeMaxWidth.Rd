\name{lakeMaxWidth}
\alias{lakeMaxWidth}
\title{Function to find line representing maximum lake Width}
\usage{
lakeMaxWidth(inLakeMorpho, pointDens, addLine = T)
}
\arguments{
  \item{inLakeMorpho}{An object of
  \code{\link{lakeMorphoClass}}.  Output of the
  \code{\link{lakeSurroundTopo}} function would be
  appropriate as input}

  \item{pointDens}{Number of points to place equidistant
  along the \code{\link{lakeMaxLength}}. A line that
  crosses at that point and extends from shore to shore is
  calcuated.}

  \item{addLine}{Boolean to determine if the selected max
  length line should be added to the inLakeMorpho object.
  Defaults to True}
}
\value{
numeric
}
\description{
Maximum lake width is defined as the maximum in lake
distance that is perpendicular to the maximum lake length.
This function calculates the equation of the perpendicular
line and repeats that line \code{pointDens} number of times
and returns the longest of those lines.
}
\examples{
data(lakes)
inputLM<-lakeSurroundTopo(exampleLake,exampleElev)
lakeMaxWidth(inputLM,100)
}
\references{
Florida LAKEWATCH (2001). A Beginner's guide to water
management - Lake Morphometry (2nd ed.). Gainesville:
Florida LAKEWATCH, Department of Fisheries and Aquatic
Sciences.
\href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
}

