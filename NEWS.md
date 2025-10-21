# pandoc (development version)

-   `pandoc_bin()` now supports `version = "quarto"` to use the Pandoc binary shipped with Quarto CLI. New convenience functions `pandoc_quarto_bin()` and `pandoc_quarto_version()` are also available.

-   Correctly order error message of Pandoc failure (thanks, \@hadley, #39).

-   `pandoc_install_nightly()` does not fail when called while a Pandoc's nigthly workflow is currently running

# pandoc 0.2.0

-   input and output path containing short path version using `~` now works (thanks, \@olivroy, #31)

-   `pandoc_install()` now works for Pandoc 3.1.2 and above on Mac as Pandoc bundles' name have changed.

-   `pandoc_install()` works now on Mac M1.

-   `pandoc_convert()` and `pandoc_export_*()` now handles filepath with space (thanks, \@krlmlr, #32).

# pandoc 0.1.0

-   First release
