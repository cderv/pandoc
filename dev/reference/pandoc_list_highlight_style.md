# List supported styles for Pandoc syntax highlighting

Pandoc includes a highlighter which offer a styling mechanism to specify
the coloring style to be used in highlighted source code. This function
returns the supported values which can be specify at `pandoc` command
line using the [`--highlight-style=`
flag](https://pandoc.org/MANUAL.html#option--highlight-style).

## Usage

``` r
pandoc_list_highlight_style(version = "default")
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

a character vector of supported highlighting style name to use.

## Examples

``` r
pandoc_list_highlight_style()
#> [1] "pygments"   "tango"      "espresso"   "zenburn"    "kate"      
#> [6] "monochrome" "breezedark" "haddock"   
if (FALSE) { # pandoc::pandoc_is_installed("2.11.4")
# check style available in a specific Pandoc's version
pandoc_list_highlight_style("2.11.4")
}
```
