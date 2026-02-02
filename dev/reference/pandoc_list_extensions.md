# List supported extensions for a format

Pandoc has a system of extensions to activate or deactivate some
features. Each format have a set of activated by default extensions and
other supported extensions than can be activated.

## Usage

``` r
pandoc_list_extensions(format = "markdown", version = "default")
```

## Arguments

- format:

  One for the supported `input` or `output` formats. See
  [`pandoc_list_formats()`](https://cderv.github.io/pandoc/dev/reference/pandoc_list_formats.md).
  It corresponds to call

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

a data.frame (or a tibble if available) with 3 columns:

- `format`: One of the Pandoc format

- `extensions` : name of the extensions

- `default`: Is the extensions activated by default or not ?

## Details

All the extensions for the last Pandoc version released are available in
<https://pandoc.org/MANUAL.html>.

## Examples

``` r
pandoc_list_extensions("markdown")
#> # A tibble: 73 × 3
#>    format   extensions               default
#>    <chr>    <chr>                    <lgl>  
#>  1 markdown abbreviations            FALSE  
#>  2 markdown all_symbols_escapable    TRUE   
#>  3 markdown angle_brackets_escapable FALSE  
#>  4 markdown ascii_identifiers        FALSE  
#>  5 markdown auto_identifiers         TRUE   
#>  6 markdown autolink_bare_uris       FALSE  
#>  7 markdown backtick_code_blocks     TRUE   
#>  8 markdown blank_before_blockquote  TRUE   
#>  9 markdown blank_before_header      TRUE   
#> 10 markdown bracketed_spans          TRUE   
#> # ℹ 63 more rows
pandoc_list_extensions("gfm")
#> # A tibble: 30 × 3
#>    format extensions             default
#>    <chr>  <chr>                  <lgl>  
#>  1 gfm    alerts                 TRUE   
#>  2 gfm    ascii_identifiers      FALSE  
#>  3 gfm    attributes             FALSE  
#>  4 gfm    autolink_bare_uris     TRUE   
#>  5 gfm    bracketed_spans        FALSE  
#>  6 gfm    definition_lists       FALSE  
#>  7 gfm    east_asian_line_breaks FALSE  
#>  8 gfm    emoji                  TRUE   
#>  9 gfm    fancy_lists            FALSE  
#> 10 gfm    fenced_divs            FALSE  
#> # ℹ 20 more rows
# target a specific version
pandoc_list_extensions("html", version = "system")
#> # A tibble: 17 × 3
#>    format extensions                default
#>    <chr>  <chr>                     <lgl>  
#>  1 html   ascii_identifiers         FALSE  
#>  2 html   auto_identifiers          TRUE   
#>  3 html   east_asian_line_breaks    FALSE  
#>  4 html   empty_paragraphs          FALSE  
#>  5 html   epub_html_exts            FALSE  
#>  6 html   gfm_auto_identifiers      FALSE  
#>  7 html   line_blocks               TRUE   
#>  8 html   literate_haskell          FALSE  
#>  9 html   native_divs               TRUE   
#> 10 html   native_spans              TRUE   
#> 11 html   raw_html                  FALSE  
#> 12 html   raw_tex                   FALSE  
#> 13 html   smart                     FALSE  
#> 14 html   task_lists                FALSE  
#> 15 html   tex_math_dollars          FALSE  
#> 16 html   tex_math_double_backslash FALSE  
#> 17 html   tex_math_single_backslash FALSE  
```
