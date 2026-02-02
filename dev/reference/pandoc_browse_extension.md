# Open Pandoc's documentation about an extension

Open Pandoc's documentation about an extension

## Usage

``` r
pandoc_browse_extension(extension = NULL)
```

## Arguments

- extension:

  One of the supported extension. See
  [`pandoc_list_extensions()`](https://cderv.github.io/pandoc/dev/reference/pandoc_list_extensions.md).
  As the Pandoc MANUAL only concerns the last released Pandoc's version,
  if the URL is incorrect this could mean the extensions has changed.

## Value

Open the webpage at the place regarding the required extension.

## Examples

``` r
pandoc_browse_extension()
#> ℹ Open URL
#> https://pandoc.org/MANUAL.html#extensions
pandoc_browse_extension("auto_identifiers")
#> ℹ Open URL
#> https://pandoc.org/MANUAL.html#extension-auto_identifiers
```
