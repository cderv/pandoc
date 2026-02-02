# Install a pandoc binary for Github release page

Binary releases of Pandoc are available on its release page. By default,
this function will install the latest available version.
`pandoc_install_nightly()` is a wrapper for `pandoc_install("nightly")`.
`pandoc_update()` is an alias for `pandoc_install()` default behavior.

## Usage

``` r
pandoc_install(version = "latest", force = FALSE)

pandoc_update()

pandoc_install_nightly(n_last = 1L)
```

## Arguments

- version:

  This can be either:

  - `"latest"` for the latest release

  - A version number (e.g `"2.11.4"`) for a specific version

  - `"nightly"` for the last pandoc development built daily

- force:

  To set to `TRUE` to force a re-installation

- n_last:

  Set to `n` as integer to install the n-th from last nightly build.
  Default is last available build (1L)

## Value

Invisibly, the path where the binary is installed otherwise. `NULL` if
already installed.

## Details

Pandoc versions are installed in user data directories with one folder
per version. See
[`pandoc_locate()`](https://cderv.github.io/pandoc/dev/reference/pandoc_locate.md).

Only one nightly version is available at a time as there should be no
need to switch between them. The latest nightly will be installed over
the current one if any. Installing nightly version is useful for example
to test a bug against the very last available built version.

## Examples

``` r
if (FALSE) { # rlang::is_interactive() && !pandoc::pandoc_is_installed("latest")
# Install the latest pandoc version
pandoc_install() # or pandoc_update()
pandoc_uninstall("latest")
}
if (FALSE) { # rlang::is_interactive() && !pandoc::pandoc_is_installed("2.11.4")
# Install a specific pandoc version
pandoc_install("2.11.4")
pandoc_uninstall("2.11.4")
}
if (FALSE) { # rlang::is_interactive() && !pandoc::pandoc_is_installed("nightly")
# Install last nightly build of pandoc
pandoc_install_nightly()
pandoc_uninstall("nightly")
}
```
