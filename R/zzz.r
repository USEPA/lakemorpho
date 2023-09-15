op <- options()

.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
"lakemorpho v01.3.0 NOTE: Version 1.3.0 of 'lakemorpho' uses 'sf' for all vector
processing.  The 'rgdal' and 'rgeos' pacakges have been removed.  'raster' is 
still used for raster data handling.  The output lakeMorpho class no longer 
contains `sp` objects.  In subsequent releases, 'lakemorpho' will use only 'sf' 
and 'terra', so please plan accordingly.")
}

.onUnload <- function(libname, pkgname){
  options(op)
  invisible()
}
