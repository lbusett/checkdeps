
<!-- README.md is generated from README.Rmd. Please edit that file -->

# checkdeps

<!-- badges: start -->

<!-- badges: end -->

The goal of checkdeps is to allow easily checking the versions of
dependencies of a given package currently installed on the user’s
system, and eventually compare them with “reference” dependencies stored
in a RData file.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lbusett/checkdeps")
```

## Example: checking currently installed versions of dependencies of an installed package:

``` r
library(checkdeps)

check_pkg_deps("MASS")
#>        Name Version Repo       date     type
#> 1 grDevices   3.6.3 base 2020-02-29  Depends
#> 2  graphics   3.6.3 base 2020-02-29  Depends
#> 3     stats   3.6.3 base 2020-02-29  Depends
#> 4     utils   3.6.3 base 2020-02-29  Depends
#> 5   methods   3.6.3 base 2020-02-29  Imports
#> 6      nlme 3.1-147 CRAN 2020-04-13 Suggests
#> 7  survival  3.1-12 CRAN 2020-04-10 Suggests
#> 8   lattice 0.20-41 CRAN 2020-04-02 Suggests
#> 9      nnet  7.3-13 CRAN 2020-02-25 Suggests

check_pkg_deps("ggplot2")
#>             Name  Version Repo       date     type
#> 1         tibble    3.0.1 CRAN 2020-04-20  Imports
#> 2          withr    2.2.0 CRAN 2020-04-20  Imports
#> 3        isoband    0.2.1 CRAN 2020-04-12  Imports
#> 4           glue    1.4.0 CRAN 2020-04-03  Imports
#> 5          rlang    0.4.5 CRAN 2020-03-01  Imports
#> 6      grDevices    3.6.3 base 2020-02-29  Imports
#> 7           grid    3.6.3 base 2020-02-29  Imports
#> 8          stats    3.6.3 base 2020-02-29  Imports
#> 9         digest   0.6.25 CRAN 2020-02-23  Imports
#> 10          MASS 7.3-51.5 CRAN 2019-12-20  Imports
#> 11        scales    1.1.0 CRAN 2019-11-18  Imports
#> 12          mgcv   1.8-31 CRAN 2019-11-09  Imports
#> 13        gtable    0.3.0 CRAN 2019-03-25  Imports
#> 14            sf    0.9-2 CRAN 2020-04-14 Suggests
#> 15          nlme  3.1-147 CRAN 2020-04-13 Suggests
#> 16       lattice  0.20-41 CRAN 2020-04-02 Suggests
#> 17         dplyr    0.8.5 CRAN 2020-03-07 Suggests
#> 18          covr    3.5.0 CRAN 2020-03-06 Suggests
#> 19      testthat    2.3.2 CRAN 2020-03-02 Suggests
#> 20       svglite    1.2.3 CRAN 2020-02-07 Suggests
#> 21         knitr     1.28 CRAN 2020-02-06 Suggests
#> 22        hexbin   1.28.1 CRAN 2020-02-03 Suggests
#> 23       mapproj    1.2.7 CRAN 2020-02-03 Suggests
#> 24     rmarkdown      2.1 CRAN 2020-01-20 Suggests
#> 25      maptools    0.9-9 CRAN 2019-12-01 Suggests
#> 26         rgeos    0.5-2 CRAN 2019-10-03 Suggests
#> 27       profvis    0.3.6 CRAN 2019-05-14 Suggests
#> 28         rpart   4.1-15 CRAN 2019-04-12 Suggests
#> 29       munsell    0.5.0 CRAN 2018-06-12 Suggests
#> 30          maps    3.3.0 CRAN 2018-04-03 Suggests
#> 31 ggplot2movies     <NA> <NA>       <NA> Suggests
#> 32         Hmisc     <NA> <NA>       <NA> Suggests
#> 33      multcomp     <NA> <NA>       <NA> Suggests
#> 34      quantreg     <NA> <NA>       <NA> Suggests
#> 35        vdiffr     <NA> <NA>       <NA> Suggests
```

## Example: saving currently installed versions of dependencies of an installed package:

``` r
library(checkdeps)
outfile <- tempfile(fileext = ".RData")
save_pkg_deps("MASS", outfile)
#> Dependencies status saved to file: D:/RTemp\RtmpOgKf2e\file3664485633e1.RData
```

## Example: comparing currently installed versions of dependencies with those saved in a file:

``` r
library(checkdeps)
prevfile <- outfile
compare_pkg_deps("MASS", prevfile)
#> = ===================================================================== =
#> All Dependencies are equal!
#> = ===================================================================== =
## basic example code
```
