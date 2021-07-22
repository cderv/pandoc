
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pandoc

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/pandoc)](https://CRAN.R-project.org/package=pandoc)
[![Codecov test
coverage](https://codecov.io/gh/cderv/pandoc/branch/main/graph/badge.svg)](https://codecov.io/gh/cderv/pandoc?branch=main)
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

### Finding an installed version

-   `pandoc::pandoc_installed_versions()`: list installed version

Pandoc versions are installed with one folder per version in user’s data
directory.

-   `pandoc::pandoc_home_dir()`: Where Pandoc versions are installed ?
-   `pandoc::pandoc_home_dir("2.11.4")`: Path to the `2.11.4` pandoc
    version directory
