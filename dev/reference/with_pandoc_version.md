# Execute any code with a specific Pandoc version

This function allows to run any R code by changing the active pandoc
version to use without modifying the R session state.

## Usage

``` r
with_pandoc_version(
  version,
  code,
  rmarkdown = getOption("pandoc.activate_rmarkdown", TRUE)
)

local_pandoc_version(
  version,
  rmarkdown = getOption("pandoc.activate_rmarkdown", TRUE),
  .local_envir = parent.frame()
)
```

## Arguments

- version:

  This can be either:

  - `"latest"` for the latest release

  - A version number (e.g `"2.11.4"`) for a specific version

  - `"nightly"` for the last pandoc development built daily

- code:

  Code to execute with the temporary active Pandoc version.

- rmarkdown:

  if `TRUE` (the default) and **rmarkdown** is available, this will also
  set the pandoc version as the default one to use with **rmarkdown** by
  calling
  [`rmarkdown::find_pandoc()`](https://pkgs.rstudio.com/rmarkdown/reference/find_pandoc.html).
  Default behavior can be changed globally by setting option
  `pandoc.activate_rmarkdown`.

- .local_envir:

  The environment to use for scoping.

## Value

The results of the evaluation of the `code` argument.

## Details

This is inspired from **withr** package.

## Examples

``` r
# Run with pandoc without activating the version for rmarkdown::render()
with_pandoc_version("system",
  pandoc_bin(),
  rmarkdown = FALSE
)
#> /opt/hostedtoolcache/pandoc/3.1.11/x64/pandoc
if (FALSE) { # pandoc::pandoc_is_installed("2.11.4") && rlang::is_installed("rmarkdown")
with_pandoc_version("2.11.4", rmarkdown::find_pandoc(), rmarkdown = TRUE)
}
if (FALSE) { # rlang::is_interactive() && pandoc::pandoc_is_installed("2.11.4")
local({
  local_pandoc_version("2.11.4")
  pandoc::pandoc_locate()
  rmarkdown::find_pandoc()
})
rmarkdown::find_pandoc()
}
```
