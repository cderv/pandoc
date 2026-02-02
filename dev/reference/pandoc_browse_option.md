# Open Pandoc's documentation about a command line option

Open Pandoc's documentation about a command line option

## Usage

``` r
pandoc_browse_option(option = NULL)
```

## Arguments

- option:

  One of the supported **long form** command line option. As the Pandoc
  MANUAL only concerns the last released Pandoc's version, if the URL is
  incorrect this could mean the option has changed.

## Value

Open the webpage at the place regarding the required option

## Examples

``` r
pandoc_browse_option()
#> ℹ Open URL
#> https://pandoc.org/MANUAL.html##options
pandoc_browse_option("embed-resources")
#> ℹ Open URL
#> https://pandoc.org/MANUAL.html#option--embed-resources
```
