# Open Pandoc's MANUAL

Open Pandoc's MANUAL

## Usage

``` r
pandoc_browse_manual(id = NULL)
```

## Arguments

- id:

  One of the id available in the HTML page (usually for anchor link).

## Value

Open the Pandoc's MANUAL

## References

<https://pandoc.org/MANUAL.html>

## Examples

``` r
# open MANUAL home page
pandoc_browse_manual()
#> ℹ Open URL
#> https://pandoc.org/MANUAL.html
# open MANUAL at math part
pandoc_browse_manual("math")
#> ℹ Open URL
#> https://pandoc.org/MANUAL.html#math
```
