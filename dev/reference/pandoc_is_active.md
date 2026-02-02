# Is a pandoc version active ?

Is a pandoc version active ?

## Usage

``` r
pandoc_is_active(version)
```

## Arguments

- version:

  This can be either:

  - `"latest"` for the latest release

  - A version number (e.g `"2.11.4"`) for a specific version

  - `"nightly"` for the last pandoc development built daily

## Value

`TRUE` is the `version` provided is currently the active one (i.e the
one used when special `"default"` keyword is used).

## See also

[`pandoc_bin()`](https://cderv.github.io/pandoc/dev/reference/pandoc_bin.md)

## Examples

``` r
# is Pandoc 2.19.2 active ?
pandoc_is_active("2.19.2")
#> [1] FALSE
# is it the Pandoc in PATH which is active ?
pandoc_is_active("system")
#> [1] TRUE
```
