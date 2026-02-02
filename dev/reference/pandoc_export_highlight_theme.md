# Export highlighting style as JSON file

Pandoc highlighting can be customize using a JSON `.theme` file, passed
to [`--highlight-style=`
flag](https://pandoc.org/MANUAL.html#option--highlight-style). This
function allows to generate the JSON version of one of the supported
highlighting style.

## Usage

``` r
pandoc_export_highlight_theme(
  style = "pygments",
  output = style,
  version = "default"
)
```

## Arguments

- style:

  One of the support highlighting style. (See
  [`pandoc_list_highlight_style()`](https://cderv.github.io/pandoc/dev/reference/pandoc_list_highlight_style.md)).

- output:

  Path (without extension) where to export the JSON `.theme` file. By
  default, the file will be located in working directory and named based
  on the parameter `style` (i.e `<style>.theme`).

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

the filename where the theme has been exported.

## Details

The `.theme` extension is required and it will be enforced in during the
export by this function.

## Note

This correspond to the [`--print-highlight-style` CLI
flag](https://pandoc.org/MANUAL.html#option--print-highlight-style)
using also `--output` to write a export a data file built in Pandoc.

## Examples

``` r
if (FALSE) { # rlang::is_interactive()
DONTSHOW({
withr::local_dir(withr::local_tempdir())
})
# export tango theme used by Pandoc highlighting to `tango.theme` file
pandoc_export_highlight_theme("tango")
pandoc_export_highlight_theme("pygments", output = "my_theme.theme")
pandoc_export_highlight_theme("zenburn", version = "system")
}
```
