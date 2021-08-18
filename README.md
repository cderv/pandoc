
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

-   `pandoc_install()` or `pandoc_install("latest")`: install last
    available released version of Pandoc

-   `pandoc_install("2.11.4")`: install Pandoc version 2.11.4

-   `pandoc_install("nighlty")` or `pandoc_install_nightly()`: install
    Pandoc devel version built daily

-   `pandoc_uninstall(<ver>)`: Uninstall one of the version

### Find an installed version

-   `pandoc::pandoc_installed_versions()`: List installed version by
    most recent first.
-   `pandoc::pandoc_is_installed("2.14.1")`: Is version 2.14.1 installed
    already ?

### Get path to a version

Pandoc versions are installed with one folder per version in user’s data
directory.

-   `pandoc::pandoc_locate()`: Path to active pandoc version directory
-   `pandoc::pandoc_locate("latest")`: Path to the most recent installed
    version
-   `pandoc::pandoc_locate("2.11.4")`: Path to a specific version
    directory, e.g `2.11.4`
-   `pandoc::pandoc_locate("nightly")`: Path to the nightly version
    installed

### Set active version

By default, the most recent Pandoc version installed is used. When
testing difference in versions, in can be interesting to switch the
active version to run a different version.

-   `pandoc::pandoc_set_version("2.7.3")`: Use a specific version with
    the package.

    By default, if **rmarkdown** is installed, it will also set the
    version active for all **rmarkdown** functions (using
    `rmarkdown::find_pandoc()`). This allows to use this package easily
    in order to test **rmarkdown** with different version of Pandoc.

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

-   `pandoc::pandoc_set_version("2.7.3", rmarkdown = FALSE)` will not
    activate the version to use with **rmarkdown**

Note: To reset default **rmarkdown** Pandoc version, you can use
`rmarkdown::find_pandoc(cache = FALSE)`
