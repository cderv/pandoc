# Activate a specific Pandoc version to be used

This function will set the specified version as the default version for
the session. By default, the default active version in the most recent
one among the installed version (nightly version excluded.)

## Usage

``` r
pandoc_activate(
  version = "latest",
  rmarkdown = getOption("pandoc.activate_rmarkdown", TRUE),
  quiet = FALSE
)
```

## Arguments

- version:

  This can be either:

  - `"latest"` for the latest release

  - A version number (e.g `"2.11.4"`) for a specific version

  - `"nightly"` for the last pandoc development built daily

- rmarkdown:

  if `TRUE` (the default) and **rmarkdown** is available, this will also
  set the pandoc version as the default one to use with **rmarkdown** by
  calling
  [`rmarkdown::find_pandoc()`](https://pkgs.rstudio.com/rmarkdown/reference/find_pandoc.html).
  Default behavior can be changed globally by setting option
  `pandoc.activate_rmarkdown`.

- quiet:

  `TRUE` to suppress messages.

## Value

invisibly, the previous active version.

## Special behavior in an interactive session

If the `version` to activate is not yet installed, the user will be
prompted to choose to install the version.

## Default active version

When the package is loaded, an active version is set to the first Pandoc
binary found between:

- the latest Pandoc version installed with this package (e.g `"2.14.2"`)

- the version shipped with RStudio IDE. (`version = "rstudio"`)

- a version available in PATH (`version = "system"`)

## Examples

``` r
if (FALSE) { # pandoc::pandoc_is_installed("2.18")
# activate version 2.18, including for use with rmarkdown package
pandoc_activate("2.18")

# activate only for this package functions and not rmarkdown
pandoc_activate("2.18", rmarkdown = FALSE)
}
```
