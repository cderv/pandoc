# Locate a specific Pandoc version installed with this package

This package helps install and manage Pandoc binaries in a specific
folder. This function helps with finding the path to those specific
versions of Pandoc. See
[`pandoc_bin()`](https://cderv.github.io/pandoc/dev/reference/pandoc_bin.md)
for another way of getting paths to `pandoc` binaries

## Usage

``` r
pandoc_locate(version = "default")
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

Path of Pandoc binaries root folder if version is available.

## See also

[`pandoc_install()`](https://cderv.github.io/pandoc/dev/reference/pandoc_install.md)

## Examples

``` r
if (FALSE) { # pandoc::pandoc_available() && !pandoc::pandoc_is_active("system") && !pandoc::pandoc_is_active("rstudio")
# where is the default active version located ?
pandoc_locate()
}
pandoc::pandoc_is_installed("2.11.4")
#> [1] FALSE
# where is a specific installed version located
pandoc_locate("2.11.4")
#> NULL
# return root folder of installed versions
pandoc_locate(NULL)
#> [1] "~/.local/share/r-pandoc"
```
