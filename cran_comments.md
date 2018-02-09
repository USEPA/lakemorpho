## Comments
Resubmission in response to 2018-02-07 Swetlana Herbrandt email.  Fixed issues
in DESCRIPTION, fixed non-ASCII characters in .Rd, removed all \\dontrun{} calls
and replaced in a few cases with \\donttest{} and \\dontshow{} as requested.  
Long double errors now solved on all functions that test for equality and CRAN 
checks pass with long double disabled 

## Test Environments
- Windows Server 2012 R2 x64 (build 9600), R version 3.4.3 Patched (2018-02-03 r74231)
- Windows 10, local R version 3.3.0 
- Ubuntu 16.04, local, R version 3.4.3 
- Ubuntu 16.04, local, R Under development (unstable) (2018-02-09 r74240) 
built and configured with --disable-long-double

## R CMD check results
- No ERRORS or WARNINGS

## Downstream dependencies
There are currently no downstream dependencies

