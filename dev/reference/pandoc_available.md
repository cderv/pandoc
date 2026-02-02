# Check if active Pandoc version meet a requirement

This function allows to test if an active Pandoc version meets a min,
max or in between requirement. See
[`pandoc_activate()`](https://cderv.github.io/pandoc/dev/reference/pandoc_activate.md)
about active version.

## Usage

``` r
pandoc_available(min = NULL, max = NULL)
```

## Arguments

- min:

  Minimum version expected.

- max:

  Maximum version expected

## Value

logical. `TRUE` if requirement is met, `FALSE` otherwise.

## Details

If `min` and `max` are provided, this will check the active version is
in-between two versions. If non is provided (keeping the default `NULL`
for both), it will check for an active version and return `FALSE` if
none is active.

## Examples

``` r
# Is there an active version available ?
pandoc_available()
#> [1] TRUE
# check for a minimum requirement
pandoc_available(min = "2.11")
#> [1] TRUE
# check for a maximum version
pandoc_available(max = "2.18")
#> [1] FALSE
# only returns TRUE if Pandoc version is between two bounds
pandoc_available(min = "2.11", max = "2.12")
#> [1] FALSE
```
