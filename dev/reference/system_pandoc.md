# Retrieve path and version of Pandoc found on the system PATH

Pandoc can also be installed on a system and available through the PATH.
Theses function are helper to easily use this specific version.

## Usage

``` r
pandoc_system_version()

pandoc_system_bin()
```

## Value

`pandoc_system_version()` returns the version number for `pandoc` binary
found in PATH as a
[`base::numeric_version()`](https://rdrr.io/r/base/numeric_version.html)
object.

`pandoc_system_bin()` returns absolute path to the `pandoc` binary found
in PATH.

## See also

[`pandoc_version()`](https://cderv.github.io/pandoc/dev/reference/pandoc_version.md),
[`pandoc_bin()`](https://cderv.github.io/pandoc/dev/reference/pandoc_bin.md)

## Examples

``` r
pandoc_system_bin()
#> /opt/hostedtoolcache/pandoc/3.1.11/x64/pandoc
```
