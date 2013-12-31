\name{lakeMeanWidth}
\alias{lakeMeanWidth}
\title{Function to return lake Mean Width}
\usage{
lakeMeanWidth(inLakeMorpho)
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
Mean lake width is the result of lake surface area divded
by the maximum length.
}
\examples{
data(lakes)
inputLM<-lakeSurroundTopo(exampleLake,exampleElev)
lakeMeanWidth(inputLM)
}
\references{
Florida LAKEWATCH (2001). A Beginner's guide to water
management - Lake Morphometry (2nd ed.). Gainesville:
Florida LAKEWATCH, Department of Fisheries and Aquatic
Sciences.
\href{http://edis.ifas.ufl.edu/pdffiles/FA/FA08100.pdf}{Link}
}

