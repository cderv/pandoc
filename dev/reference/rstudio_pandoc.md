# Retrieve path and version of Pandoc shipped with RStudio

RStudio IDE ships with a pandoc binary. The path is stored in
`RSTUDIO_PANDOC` environment variable. Theses function are helper to
easily use this specific version.

## Usage

``` r
pandoc_rstudio_version()

pandoc_rstudio_bin()
```

## Value

`pandoc_rstudio_version()` returns the version number for `pandoc`
binary used by RStudio IDE as a
[`base::numeric_version()`](https://rdrr.io/r/base/numeric_version.html)
object.

[`pandoc_system_bin()`](https://cderv.github.io/pandoc/dev/reference/system_pandoc.md)
returns absolute path to the `pandoc` binary used by RStudio IDE.

## See also

[`pandoc_version()`](https://cderv.github.io/pandoc/dev/reference/pandoc_version.md),
[`pandoc_bin()`](https://cderv.github.io/pandoc/dev/reference/pandoc_bin.md)

## Examples

``` r
if (FALSE) { # !is.null(pandoc::pandoc_rstudio_bin())
}
pandoc_rstudio_bin()
#> NULL
```
