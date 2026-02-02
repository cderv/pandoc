# Run Pandoc to convert a document or a text

Main usage of Pandoc is to convert some text from a format into another.
This function will do just that:

- converting from a file or directly from text

- writing to a file or directly to console

## Usage

``` r
pandoc_convert(
  file = NULL,
  text = NULL,
  from = "markdown",
  to,
  output = NULL,
  standalone = FALSE,
  args = c(),
  version = "default"
)
```

## Arguments

- file, text:

  One or the other should be provided

- from:

  Format to convert from. This must be one of the format supported by
  Pandoc. Default will be `markdown`. This correspond to the
  [`--from/-f` CLI flag](https://pandoc.org/MANUAL.html#option--from)

- to:

  Format to convert to. This must be one of the format supported by
  Pandoc. This correspond to the [`--to/-t` CLI
  flag](https://pandoc.org/MANUAL.html#option--to).

- output:

  Pass a path to a file to write the result from Pandoc conversion into
  a file. This corresponds to the [`--output/-o`
  flag](https://pandoc.org/MANUAL.html#option--output)

- standalone:

  Should appropriate header and footer be included ? This corresponds to
  [`--standalone/-s` CLI
  flag](https://pandoc.org/MANUAL.html#option--standalone)

- args:

  Any other flag supported by Pandoc CLI. See
  <https://pandoc.org/MANUAL.html#options>

- version:

  Version to use. Default will be the `"default"` version. Other
  possible value are

  - A version number e.g `"2.14.1"`

  - The nightly version called `"nightly"`

  - The latest installed version with `"latest"`

  - Pandoc binary shipped with RStudio IDE with `"rstudio"`

  - Pandoc binary found in PATH with `"system"`

  - Pandoc binary shipped with Quarto CLI with `"quarto"`

## Value

`output` is provided, the absolute file path. If not, the output of
`pandoc` binary run.

## Examples

``` r
pandoc::pandoc_convert(text = "_This will be emphasize_", to = "latex")
#> \emph{This will be emphasize}
if (FALSE) { # pandoc::pandoc_is_installed("2.11.4")
pandoc::pandoc_convert(text = "**This will be bold**", to = "html", version = "2.11.4")
}
```
