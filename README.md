
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pandoc

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/pandoc)](https://CRAN.R-project.org/package=pandoc)
[![Codecov test
coverage](https://codecov.io/gh/cderv/pandoc/branch/main/graph/badge.svg?token=84QW1TDQPM)](https://codecov.io/gh/cderv/pandoc?branch=main)
[![R-CMD-check](https://github.com/cderv/pandoc/workflows/R-CMD-check/badge.svg)](https://github.com/cderv/pandoc/actions)
<!-- badges: end -->

**pandoc** R package is an experimental package aiming first to help
maintainers of R Markdown ecosystem.

The R Markdown ecosystem is highly dependent on Pandoc
<https://pandoc.org/> and aims to be as version independent as possible.
R Markdown is best used with the latest Pandoc version but any rmarkdown
package version should work with previous version, and new change in
Pandoc should not break any rmarkdown features.

This explain the needs to some more focused tooling to:

-   Install and manage several pandoc versions. This is useful for
    testing versions and comparing between them.
-   Call pandoc directly without the layers added by **rmarkdown**. This
    is useful for debugging or quickly iterating and finding where a bug
    could be.
-   Retreive information from Pandoc directly. Each version comes with
    changes and some of them are included into the binary. Being able to
    retrieve those information and compare between version is also
    important to help maintain the user exposed tooling.

## Installation

The development version can be install from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("cderv/pandoc")

# install.packages("pak", repos = "https://r-lib.github.io/p/pak/dev/")
pak::pak("cderv/pandoc")
```

## Main features

### Installation of Pandoc version

These functions are useful to install and manage Pandoc binaries,
independently of other installed versions (by others tools.)

-   `pandoc_install()` or `pandoc_install("latest")`: install last
    available released version of Pandoc

-   `pandoc_install("2.11.4")`: install Pandoc version 2.11.4

-   `pandoc_install("nightly")` or `pandoc_install_nightly()`: install
    Pandoc devel version built daily

-   `pandoc_uninstall(<ver>)`: Uninstall one of the version

### Find an installed version by this package

These functions can be used to check for a version installed by this
package.

-   `pandoc::pandoc_installed_versions()`: List installed version by
    most recent first.
-   `pandoc::pandoc_installed_latest()`: Get the most recent version
    number installed.  
-   `pandoc::pandoc_is_installed("2.14.1")`: Is version 2.14.1 installed
    already ?

### Get path to a version

#### Get directory for a version installed by `pandoc_install()`

Pandoc versions installed by this package are located within one folder
per version in a user’s data directory. `pandoc_locate(version)` will
help find the directory in which a pandoc version is available:

-   `pandoc::pandoc_locate()`: Path to active pandoc version directory
-   `pandoc::pandoc_locate("latest")`: Path to the most recent installed
    version directory
-   `pandoc::pandoc_locate("2.11.4")`: Path to a specific version
    directory, e.g `2.11.4`
-   `pandoc::pandoc_locate("nightly")`: Path to the directory of the
    nightly version installed

#### Get full path to a binary: `pandoc` or `pandoc.exe` (windows)

To get full path to a pandoc binary, one can use

-   `pandoc_bin()`: Path to active pandoc version binary
-   `pandoc_bin("latest")`: Path to the most recent installed version
    binary
-   `pandoc_bin("2.11.4")`: Path to a specific version binary
-   `pandoc_bin("nightly")`: Path to binary of the nightly version
    installed

This function will also support external Pandoc binaries, with two
aliases

-   the one shipped with RStudio IDE:
    -   `pandoc::pandoc_bin("rstudio")`
    -   `pandoc::pandoc_rstudio_bin()`
-   the one set by default on the system (in PATH):
    -   `pandoc::pandoc_bin("system")`
    -   `pandoc::pandoc_system_bin()`

### Set active version

When the package is loaded, a default active version is set following
this search order:

-   Latest (i.e highest) version installed using `pandoc_install()`
    found.
-   RStudio version (usually set when used in RStudio IDE)
-   System version found in PATH

When testing difference between versions, it can be interesting to
switch the active version to run a different version. This can be done
with `pandoc_set_version(<version)`

``` r
# Use a specific numbered version with the package
pandoc::pandoc_set_version("2.7.3")

# Use the nightly version installed if available
pandoc::pandoc_set_version("nighlty")

# Use RStudio shipped Pandoc
pandoc::pandoc_set_version("rstudio")

# Use System Pandoc found in PATH
pandoc::pandoc_set_version("system")
```

#### Working with **rmarkdown** functions

By default, if **rmarkdown** is installed, it will also set the version
active for all **rmarkdown** functions (using
`rmarkdown::find_pandoc()`). This allows to use this package easily in
order to test **rmarkdown** with different version of Pandoc.

``` r
rmarkdown::find_pandoc(cache = FALSE)
#> $version
#> [1] '2.14.1'
#> 
#> $dir
#> [1] "C:/Users/chris/scoop/shims"
pandoc::pandoc_set_version("2.7.3")
#> v Version 2.7.3 is now the active one.
#> i This is also true for using with rmarkdown functions.
rmarkdown::find_pandoc()
#> $version
#> [1] '2.7.3'
#> 
#> $dir
#> [1] "C:\\Users\\chris\\AppData\\Local/r-pandoc/r-pandoc/2.7.3"
```

Setting `rmarkdown = TRUE` is equivalent to calling

``` r
rmarkdown::find_pandoc(cache = FALSE, dir = pandoc::pandoc_locate())
```

`pandoc::pandoc_set_version("2.7.3", rmarkdown = FALSE)` will not
activate the version to use with **rmarkdown**

##### Resetting **rmarkdown** default Pandoc version

Note: To reset default **rmarkdown** Pandoc version, you can use
`rmarkdown::find_pandoc(cache = FALSE)`

### Is Pandoc available ?

``` r
# Is a pandoc version available (i.e a version is active), and if so what is the full path ? 
if (pandoc_available()) pandoc_bin()

# Is the active version above 2.10.1 ?
pandoc_available(min = "2.10.1")
# Is the active version below 2.11 ?
pandoc_available(max = "2.11")
# Is the active version between 2.10.1 and 2.11, both side include ?
pandoc_available(min = "2.10.1, max = "2.11")
```
