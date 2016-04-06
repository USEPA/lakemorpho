lakemorpho 1.0.1 (2015-03-16)
=============================

## New Features
- Added vignette describing package and a typical use case.  Vignette also
  available as publication from [Hollister 2015]().

## Bug Fixes
- `lakeMaxWidth()` was flipping slope of line on lakes with a maximum lake length that had negative slope.  Tracked down to creating a line with `matrix()`. Switched to `data.frame()` and now works.

## API Changes
- lakeFetch - bearing parameter no long character, accepts numeric (0-360).  
             
## Minor Changes
- Fixed several typos in documentation
- Corrected older documenation that doesn't reflect current API
- Re-generated documentation with roxygen2 4.1.0
- Added NEWS.md

