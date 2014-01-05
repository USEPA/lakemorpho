\name{plot.lakeMorpho}
\alias{plot.lakeMorpho}
\title{Default plotting of a lakeMorpho object}
\usage{
\method{plot}{lakeMorpho}(x, ...)
}
\arguments{
  \item{x}{input lakeMorpho class to plot}

  \item{...}{allows for passing of other plot parameters}
}
\description{
Plots the lakeMorpho class by showing lake, surround
topography and in lake distance
}
\examples{
data(lakes)
inputLM<-lakeSurroundTopo(exampleLake,exampleElev)
plot(inputLM)
}

