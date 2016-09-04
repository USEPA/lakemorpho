[![travis_status](https://travis-ci.org/jhollist/lakemorpho.svg)](https://travis-ci.org/jhollist/lakemorpho)  

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/jhollist/lakemorpho?branch=master)](https://ci.appveyor.com/project/jhollist/lakemorpho) 

[![DOI](https://zenodo.org/badge/4384/jhollist/lakemorpho.svg)](https://zenodo.org/badge/latestdoi/4384/jhollist/lakemorpho)

[![RStudio_CRAN_Downloads](http://cranlogs.r-pkg.org/badges/lakemorpho)](http://cranlogs.r-pkg.org/badges/lakemorpho)

# lakemorpho
The purpose of `lakemorpho` is to provide a suite of tools that can be used to calculate basic lake morphometry metrics from an input SpatialPolygonsDataframe of a lake and a digital elevation model, as a RasterLayer, for the terrain surrounding that lake.  These tools are being used to calculate lake morphometry metrics for all "lakepond" waterbodies in the [NHDPlus V2](http://www.horizon-systems.com/nhdplus/NHDPlusV2_home.php).

# Metrics Included
`lakemorpho` calculates the following metrics

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
Install version 1.0 of `lakemorpho` from CRAN:

```
install.packages("lakemorpho")
require(lakemorpho)
```

Install development version of `lakemorpho` from GitHub:

```
install.packages("devtools")
require(devtools)
install_github("USEPA/lakemorpho")
require(lakemorpho)
```


# EPA Disclaimer
The United States Environmental Protection Agency (EPA) GitHub project code is provided on an "as is" basis and the user assumes responsibility for its use.  EPA has relinquished control of the information and no longer has responsibility to protect the integrity , confidentiality, or availability of the information.  Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recomendation or favoring by EPA.  The EPA seal and logo shall not be used in any manner to imply endorsement of any commercial product or activity by EPA or the United States Government. 


### EPA Static Source
If for some reason you need a link to a static source file that is accessible from [US EPA](http://cfpub.epa.gov/si/si_public_record_report.cfm?dirEntryId=265049).  
