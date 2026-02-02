# Retrieve path and version of Pandoc shipped with Quarto CLI

Quarto CLI ships with a pandoc binary. The path can be found by running
`quarto --paths` command. These functions are helpers to easily use this
specific version.

## Usage

``` r
pandoc_quarto_version()

pandoc_quarto_bin()
```

## Value

`pandoc_quarto_version()` returns the version number for `pandoc` binary
used by Quarto CLI as a
[`base::numeric_version()`](https://rdrr.io/r/base/numeric_version.html)
object.

`pandoc_quarto_bin()` returns absolute path to the `pandoc` binary used
by Quarto CLI.

## See also

[`pandoc_version()`](https://cderv.github.io/pandoc/dev/reference/pandoc_version.md),
[`pandoc_bin()`](https://cderv.github.io/pandoc/dev/reference/pandoc_bin.md)

## Examples

``` r
if (FALSE) { # !is.null(pandoc::pandoc_quarto_bin())
}
pandoc_quarto_bin()
#> NULL
```
