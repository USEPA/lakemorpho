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

# EPA Disclaimer
The United States Environmental Protection Agency (EPA) GitHub project code is provided on an "as is" basis and the user assumes responsibility for its use.  EPA has relinquished control of the information and no longer has responsibility to protect the integrity , confidentiality, or availability of the information.  Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recomendation or favoring by EPA.  The EPA seal and logo shall not be used in any manner to imply endorsement of any commercial product or activity by EPA or the United States Government.
