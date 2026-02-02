# Get Pandoc version

This is calling `pandoc --version` to retrieve the version of Pandoc
used. A special treatment is done for *nightly* version as Pandoc
project does not use a development version scheme between released
versions. This function will add a `.9999` suffix to the version
reported by Pandoc.

## Usage

``` r
pandoc_version(version = "default")
```

## Arguments

- version:

  Version to use. Default will be the `"default"` version. Other
  possible value are

  - A version number e.g `"2.14.1"`

  - The nightly version called `"nightly"`

  - The latest installed version with `"latest"`

  - Pandoc binary shipped with RStudio IDE with `"rstudio"`

  - Pandoc binary found in PATH with `"system"`

  - Pandoc binary shipped with Quarto CLI with `"quarto"`

## Value

The version number for `pandoc` binary as a
[`base::numeric_version()`](https://rdrr.io/r/base/numeric_version.html)
object.

## Examples

``` r
pandoc::pandoc_version()
#> [1] ‘3.1.11’
pandoc::pandoc_version(version = "system")
#> [1] ‘3.1.11’
```
