
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pandoc

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/pandoc)](https://github.com/cderv/pandoc)
[![R-CMD-check](https://github.com/cderv/pandoc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/cderv/pandoc/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/cderv/pandoc/branch/main/graph/badge.svg)](https://app.codecov.io/gh/cderv/pandoc?branch=main)

<!-- badges: end -->

**pandoc** is currently an experimental R package primarily develop to
help maintainers of R Markdown ecosystem.

Indeed, the R Markdown ecosystem is highly dependent on Pandoc
(<https://pandoc.org/>) changes and it is designed to be as version
independent as possible. R Markdown is best used with the latest Pandoc
version but any **rmarkdown** package version should work with previous
version of Pandoc, and new change in Pandoc should not break any
**rmarkdown** features.

This explains the needs for a more focused tooling to:

-   Install and manage several Pandoc versions. This is useful for
    testing versions and comparing between them.
-   Call Pandoc’s command directly without the layers added by
    **rmarkdown**. This is useful for debugging or quickly iterating and
    finding where a bug comes from.
-   Retrieve information from Pandoc directly. Each version comes with
    changes and some of them are included into the binary. Being able to
    retrieve those information and compare between versions is important
    to help maintain the user exposed tooling.

This package can also be useful to advanced developers that are working
around Pandoc through **rmarkdown** or not.

## Installation

Install from CRAN:

``` r
install.packages("pandoc")
```

The development version can be install from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("cderv/pandoc")

# install.packages("pak")
pak::pak("cderv/pandoc")
```

## Usage

All functions are prefixed with `pandoc_` and you will find below their
main usage. See [Get started](articles/pandoc.html) for usage examples
and [Reference](reference/index.html) page for full details of
functions.

Most functions follows these following rules:

-   They are prefixed with `pandoc_` .
-   They can be used with any installed Pandoc version using `version`
    argument.
-   Versions to use are passed as a string, either the version number
    (e.g `"2.14.2"` ), or one special alias (`default`, `nightly` ,
    `rstudio` , `system`) .

Available functions allows:

-   Installing / Uninstalling specific Pandoc version from ‘2.0.3’ to
    ‘2.18’ , including development version of Pandoc.
    -   `pandoc_install()`, `pandoc_install_nightly()`,
        `pandoc_uninstall()`, …
-   Switching Pandoc version by activating a specific one or running any
    function with a specific Pandoc version using `version=` argument.
    -   `pandoc_activate()` , `with_pandoc()` , ….
-   Managing locally installed version of Pandoc as versions installed
    by this package are located within one folder per version in a
    user’s data directory.
    -   `pandoc_installed_versions()` , `pandoc_installed_latest` ,
        `pandoc::pandoc_is_installed()` , `pandoc_locate()`,
        `pandoc_available()`, …
-   Using easily one of the installed version with **rmarkdown** (i.e
    `rmarkdown::render()` will use the version activated by this pandoc)
    -   See `pandoc::pandoc_activate(rmarkdown = TRUE)`
-   Running a Pandoc binary from R, including a version installed
    system-wise (`pandoc_bin("system")`), or the version shipped with
    RStudio (`pandoc_bin("rstudio")`).
-   Calling binary at low-level from R with any version installed.
    -   `pandoc_run()`
-   to easily access information in R usually requiring command line
    execution
    -   `pandoc_version()`, `pandoc_list_extensions()` ,
        `pandoc_export_template()` , and all other wrappers…
-   opening Pandoc’s resources from R
    -   `pandoc::pandoc_browse_manual()`,
        `pandoc::pandoc_browse_extension()` , ….

## Example

``` r
library(pandoc)
# Install version
pandoc_install("2.7.3")
#> ✔ Pandoc 2.7.3 already installed.
#>   Use 'force = TRUE' to overwrite.
pandoc_install("2.11.4")
#> ✔ Pandoc 2.11.4 already installed.
#>   Use 'force = TRUE' to overwrite.
# Highest install is used
pandoc_version()
#> [1] '2.18'
```

See detailed examples in [Get started](articles/pandoc.html).

## Code of Conduct

Please note that the **pandoc** project is released with a [Contributor
Code of Conduct](https://cderv.github.io/pandoc/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
