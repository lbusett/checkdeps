
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

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(checkdeps)
check_pkg_deps("ggplot2")
#>         Name  Version Repo       date
#> 1      withr    2.2.0 CRAN 2020-04-20
#> 2    isoband    0.2.1 CRAN 2020-04-12
#> 3       glue    1.4.0 CRAN 2020-04-03
#> 4     tibble    3.0.0 CRAN 2020-03-30
#> 5      rlang    0.4.5 CRAN 2020-03-01
#> 6  grDevices    3.6.3 base 2020-02-29
#> 7       grid    3.6.3 base 2020-02-29
#> 8      stats    3.6.3 base 2020-02-29
#> 9     digest   0.6.25 CRAN 2020-02-23
#> 10      MASS 7.3-51.5 CRAN 2019-12-20
#> 11    scales    1.1.0 CRAN 2019-11-18
#> 12      mgcv   1.8-31 CRAN 2019-11-09
#> 13    gtable    0.3.0 CRAN 2019-03-25
## basic example code
```
