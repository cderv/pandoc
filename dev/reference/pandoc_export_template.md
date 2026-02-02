# Retrieve Pandoc template for a format

This correspond to the [`--print-default-template` CLI
flag](https://pandoc.org/MANUAL.html#option--print-default-template).
With this function, one can easily export default LaTeX template for
example.

## Usage

``` r
pandoc_export_template(format = "markdown", output = NULL, version = "default")
```

## Arguments

- format:

  One of Pandoc format using a text template. (e.g html, latex,
  revealjs)

- output:

  Path where to save the file. If not provided, the default, template
  content will be print to the console.

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

If `output` is not provided, the content of the template will be printed
and return as one string (invisibly). If `output` is provided, the file
path of the output (invisibly).

## Examples

``` r
pandoc_export_template()
#> $if(titleblock)$
#> $titleblock$
#> 
#> $endif$
#> $for(header-includes)$
#> $header-includes$
#> 
#> $endfor$
#> $for(include-before)$
#> $include-before$
#> 
#> $endfor$
#> $if(toc)$
#> $table-of-contents$
#> 
#> $endif$
#> $body$
#> $for(include-after)$
#> 
#> $include-after$
#> $endfor$
if (FALSE) { # rlang::is_interactive()
DONTSHOW({
withr::local_dir(withr::local_tempdir())
})
pandoc_export_template("latex", output = "default.tex", version = "system")
}
```
