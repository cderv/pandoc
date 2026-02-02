# Get path to the pandoc-citeproc binary.

This function will return the path to `pandoc-citeproc` if available. It
will only work with `version` of Pandoc installed by this package.

## Usage

``` r
pandoc_citeproc_bin(version = "default")
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

the path to `pandoc-citeproc` binary if it exists. Since Pandoc 2.11,
the citeproc filter has been included into Pandoc itself and is no more
shipped as a binary filter.

## Examples

``` r
if (FALSE) { # rlang::is_interactive()
# Look into current active version
pandoc_citeproc_bin()
}
if (FALSE) { # pandoc::pandoc_is_installed("2.9.2")
# Look into a specific version
pandoc_citeproc_bin("2.9.2")
}
```
