# Get path to the pandoc binary

Get path to the pandoc binary

## Usage

``` r
pandoc_bin(version = "default")

pandoc_bin_browse(version = "default")
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

Absolute path to the pandoc binary of the requested version.

## Details

`pandoc_bin_browse()` allows to open in OS explorer the folder where
`pandoc_bin()` is at, when in interactive mode only.

## Examples

``` r
pandoc_bin()
#> /opt/hostedtoolcache/pandoc/3.1.11/x64/pandoc
pandoc_bin("2.18")
#> NULL
pandoc_bin("nightly")
#> NULL
pandoc_bin("rstudio")
#> NULL
pandoc_bin("system")
#> /opt/hostedtoolcache/pandoc/3.1.11/x64/pandoc
pandoc_bin("quarto")
#> NULL
pandoc_bin_browse("2.18")
#> NULL
```
