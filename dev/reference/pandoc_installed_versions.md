# Check Pandoc versions already installed

- `pandoc_installed_versions()` lists all versions already installed

- `pandoc_installed_latest()` returns the most recent installed version

- `pandoc_is_installed()` allows to check for a specific installed
  version

## Usage

``` r
pandoc_installed_versions()

pandoc_installed_latest()

pandoc_is_installed(version, error = FALSE, ask = FALSE)
```

## Arguments

- version:

  This can be either:

  - `"latest"` for the latest release

  - A version number (e.g `"2.11.4"`) for a specific version

  - `"nightly"` for the last pandoc development built daily

- error:

  if `TRUE` an error will be raised if the result is `FALSE`

- ask:

  if `TRUE`, the user will be prompt in an interactive

## Value

A character vector of installed versions or a logical for
`pandoc_is_installed()`. It will return `NULL` is no versions are
installed.

For `pandoc_is_installed()`, `TRUE` if only the required version is
installed. If `FALSE` and `ask` is `TRUE`, the user will be prompt for
installing the version.

## Examples

``` r
pandoc_installed_versions()
#> NULL
pandoc_installed_latest()
#> NULL
pandoc_is_installed("2.19.2")
#> [1] FALSE
pandoc_installed_latest()
#> NULL
```
