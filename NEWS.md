lakemorpho 1.2.1 (2022-04-25)
==========================

## Bug fixes
- @aarohall caught a bug with user supplied catchment returning a Null 
surrounding landscape.

lakemorpho 1.2.0 (2021-09-23)
==========================

## Bug fixes
- @data@values was not returning vector as thought, switched all of these to 
raster::getValues (thanks to Laura Read for catching this)
- Fixed volume calcs in calcLakeMetrics with named arguments (Thanks to Viktor Gydemo Östbom for the find)

## Function changes
- added ability to save pseudo bathymetry from lakeVolume to input lake morpho 
object (thanks to Bahram Khazaei for suggetsion).
- added slope_quant arqument to lakeMaxDepth to allow for other quantiles 
besides the median to be used to estimate depth.  Median is the default  
(thanks to Arthur Heyman for the suggestion).
- Added major and minor axis metrics to calcLakeMetrics.
- lakeVolume now has option for outputting the psuedoBathy raster to the lakeMorpho object.
- Can now run metrics without a elevation raster.  Returns NA if not included for those metrics that need a depth or an elevation raster.

## DESCRIPTION changes
- Author/Contributor changes and name change.

## Other Changes
- DOI links fixed (thanks, @katrinleinweber)
- Several typo corrections
- set rgdal warnings to thin
- Stale sp objects updated
- Fixes GH Actions
- Added new citation file

lakemorpho 1.1.1 (2018-02-07)
==========================

## Bug fixes and other changes
- Throwing errors related to noLD/long double issues, fixed by rounding '==' 
checks to 8 digits.
- Removed maptools dependency and internal checking of polygon holes.  Assumes
clean polygons to start.
- Cleaned up DESCRIPTION
- Fixed encoding issue in lakeMajorAxisLength documentation
- Removed several of the /dontrun on examples.

lakemorpho 1.1.0 (2016-12-27)
=============================

## New Functions
- lakeMajorAxisLength added to calculate the length of the Major Axis.  This is calcualted from the convex hull of all points that represent the polygon.  (Thanks to Jemma Stachelek for the contribution!)
- lakeMinorAxisLength added to calculate the length of the Mino Axis.  This is calcualted from the convex hull of all points that represent the polygon.  (Thanks to Jemma Stachelek for the contribution!)
- lakeMinorMajorAxisRatio added to calculate the ratio of the Minor and Major axis lengths (Thanks to Jemma Stachelek for the contribution!)

## Minor Changes
- Update to description, added Jemma Stachelek as contributor
- Added major and minor axis lines to default plot
- Updated R Depends to version 3.0.0

lakemorpho 1.0.4 (2016-10-14)
=============================

## Minor Changes
- cleaned up package description

## API Change
- added a depth parameter, zmax,  to `lakeVolume` and `lakeMeanDepth` (passed to `lakeVolume`) to allow input a known maximum depth.  If not included and an elevation model is included in the lake morpho object, max depth is estimated with `lakeMaxDepth`.



lakemorpho 1.0.3 (2016-09-02)
=============================

## Minor Changes
- Request from CRAN to add vignette builder to DESCRIPTION; however, vignette complete.  Removed vignette from build and resubmitted.  Bumped minor version


lakemorpho 1.0.2 (2016-05-14)
=============================

## New Features
- Added `intersect=` argument on `lakeMaxWidth()`.  Default is `FALSE` which finds longest line perpendicular to the maximum length line, but not necessarily intersecting with the maximum length line.  `TRUE` forces the intersection.  The definition of maximum lake width does not specify whether or not the intersection is required.

## Bug Fixes
- `lakeMaxWidth()` was flipping slope of line on lakes with a maximum lake length that had negative slope.  Tracked down to creating a line with `matrix()`. Switched to `data.frame()` and now works.
- `lakeMaxLength()` was using `rgeos::gWithin` to ID lines that fell inside the lake boundary.  Would occassionally select a line that was outside the boundary on curved lakes (e.g. s-shaped).  Couldn't track down why this was happening, but `rgeos::gContains()` did not have this same behavior, so replaced `gWithin()` with `gContains`.
- switched `paste(substitue())` to `deparse(substitute())` 

## API Changes
- lakeFetch - bearing parameter no long character, accepts numeric (0-360).  
             
## Minor Changes
- Fixed several typos in documentation
- Corrected older documenation that doesn't reflect current API
- Re-generated documentation with roxygen2 4.1.0
- `lakeSurroundTopo()` now returns stops and errors when multiple polygons submitted. 
- `lakeMorphoClass()` now accepts lake only.  Other arguments have defualt NULL values.
- Default plot accepts NULLS in `lakeMorphoClass` and plots lines if they exist.
- Added NEWS.md
- Added elevation checks for functions that require it.
- check now error, instead of warns, when wrong input is supplied


