# Uninstall a Pandoc version

You can run
[`pandoc_installed_versions()`](https://cderv.github.io/pandoc/dev/reference/pandoc_installed_versions.md)
to see which versions are currently installed on the system.

## Usage

``` r
pandoc_uninstall(version)
```

## Arguments

- version:

  which version to uninstalled.

## Value

`TRUE` (invisibly) if uninstalling is successful.

## See also

[`pandoc_install()`](https://cderv.github.io/pandoc/dev/reference/pandoc_install.md)

## Examples

``` r
if (FALSE) { # rlang::is_interactive() && !pandoc::pandoc_is_installed("2.19.2")
pandoc_install("2.19.2")
pandoc_is_installed("2.19.2")
pandoc_uninstall("2.19.2")
}
```
