# Changelog

## pandoc (development version)

- [`pandoc_bin()`](https://cderv.github.io/pandoc/dev/reference/pandoc_bin.md)
  now supports `version = "quarto"` to use the Pandoc binary shipped
  with Quarto CLI. New convenience functions
  [`pandoc_quarto_bin()`](https://cderv.github.io/pandoc/dev/reference/quarto_pandoc.md)
  and
  [`pandoc_quarto_version()`](https://cderv.github.io/pandoc/dev/reference/quarto_pandoc.md)
  are also available.

- Correctly order error message of Pandoc failure (thanks,
  [@hadley](https://github.com/hadley),
  [\#39](https://github.com/cderv/pandoc/issues/39)).

- [`pandoc_install_nightly()`](https://cderv.github.io/pandoc/dev/reference/pandoc_install.md)
  does not fail when called while a Pandoc’s nigthly workflow is
  currently running

## pandoc 0.2.0

CRAN release: 2023-08-24

- input and output path containing short path version using `~` now
  works (thanks, [@olivroy](https://github.com/olivroy),
  [\#31](https://github.com/cderv/pandoc/issues/31))

- [`pandoc_install()`](https://cderv.github.io/pandoc/dev/reference/pandoc_install.md)
  now works for Pandoc 3.1.2 and above on Mac as Pandoc bundles’ name
  have changed.

- [`pandoc_install()`](https://cderv.github.io/pandoc/dev/reference/pandoc_install.md)
  works now on Mac M1.

- [`pandoc_convert()`](https://cderv.github.io/pandoc/dev/reference/pandoc_convert.md)
  and `pandoc_export_*()` now handles filepath with space (thanks,
  [@krlmlr](https://github.com/krlmlr),
  [\#32](https://github.com/cderv/pandoc/issues/32)).

## pandoc 0.1.0

CRAN release: 2022-09-29

- First release
