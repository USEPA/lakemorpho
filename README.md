# lakemorpho
The purpose of `lakemorpho` is to provide a suite of tools that can be used to calculate basic lake morphometry metrics from an input SpatialPolygonsDataframe of a lake and a digital elevation model for the terrain surrounding that lake.  These tools are being used to calculate lake morphometry metrics for all "lakepond" waterbodies in the [NHDPlus V2](http://www.horizon-systems.com/nhdplus/NHDPlusV2_home.php).

# Metrics Included
'lakemorpho'calculates the following metrics

- Surface Area
- Shoreline Length
- Shoreline Development
- Maximum Depth
- Mean Depth
- Lake Volume
- Maximum Lake Length
- Mean Lake Width
- Maximum Lake Width 
- Fetch from a specified bearing

# To install 
(instructions borrowed from [ROpenSci](https://github.com/ropensci))

Or install development version of rdryad from GitHub:

```coffee
install.packages("devtools")
require(devtools)
install_github("lakemorpho", "USEPA")
require(lakemorpho)
```


