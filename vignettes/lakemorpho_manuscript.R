## ----setup, include=FALSE, echo=FALSE------------------------------------
#Put whatever you normally put in a setup chunk.
library("knitr")
library("lakemorpho")
library("rgdal")
library("sp")
library("rgeos")
library("knitr")

opts_chunk$set(dev = 'pdf', fig.width=6, fig.height=5)

# Table Captions from @DeanK on http://stackoverflow.com/questions/15258233/using-table-caption-on-r-markdown-file-using-knitr-to-use-in-pandoc-to-convert-t
#Figure captions are handled by LaTeX

knit_hooks$set(tab.cap = function(before, options, envir) {
                  if(!before) { 
                    paste('\n\n:', options$tab.cap, sep='') 
                  }
                })
default_output_hook = knit_hooks$get("output")
knit_hooks$set(output = function(x, options) {
  if (is.null(options$tab.cap) == FALSE) {
    x
  } else
    default_output_hook(x,options)
})

## ----analysis , include=FALSE, echo=FALSE, cache=FALSE-------------------
#All analysis in here, that way all bits of the paper have access to the final objects
#Place tables and figures and numerical results where they need to go.

## ----lakeSurroundTopo_example--------------------------------------------
#Load data
data(lakes)

#Create lakeMorpho object, example_lakeMorpho, with required inputs
example_lakeMorpho <- lakeSurroundTopo(exampleLake, exampleElev)

## ----lakeSurroundTopo_exmaple_output-------------------------------------
lapply(example_lakeMorpho,class)

## ----lakeFetchExample----------------------------------------------------
#Fetch for North
lakeFetch(example_lakeMorpho, 0)
lakeFetch(example_lakeMorpho, 360)

#Fetch for West
lakeFetch(example_lakeMorpho, 270)

## ----lakeMaxDepthExample-------------------------------------------------
#Maximum Lake Depth
lakeMaxDepth(example_lakeMorpho)

