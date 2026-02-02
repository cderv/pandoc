# List available supported formats

List available supported formats

## Usage

``` r
pandoc_list_formats(type = c("input", "output"), version = "default")
```

## Arguments

- type:

  Either list `input` or `output` formats. It corresponds to call
  `--list-input-formats` and `--list-output-formats` respectively.

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

a data.frame (or a tibble if available) with 2 column:

- `type` (input or output)

- `formats` (name of the formats that can be used as input or output)

## Examples

``` r
# which input formats are available
pandoc_list_formats()
#> # A tibble: 44 × 2
#>    type  formats     
#>    <chr> <chr>       
#>  1 input biblatex    
#>  2 input bibtex      
#>  3 input bits        
#>  4 input commonmark  
#>  5 input commonmark_x
#>  6 input creole      
#>  7 input csljson     
#>  8 input csv         
#>  9 input docbook     
#> 10 input docx        
#> # ℹ 34 more rows
# which output formats are available
pandoc_list_formats()
#> # A tibble: 44 × 2
#>    type  formats     
#>    <chr> <chr>       
#>  1 input biblatex    
#>  2 input bibtex      
#>  3 input bits        
#>  4 input commonmark  
#>  5 input commonmark_x
#>  6 input creole      
#>  7 input csljson     
#>  8 input csv         
#>  9 input docbook     
#> 10 input docx        
#> # ℹ 34 more rows
# target a specific version
pandoc_list_formats("input", version = "system")
#> # A tibble: 44 × 2
#>    type  formats     
#>    <chr> <chr>       
#>  1 input biblatex    
#>  2 input bibtex      
#>  3 input bits        
#>  4 input commonmark  
#>  5 input commonmark_x
#>  6 input creole      
#>  7 input csljson     
#>  8 input csv         
#>  9 input docbook     
#> 10 input docx        
#> # ℹ 34 more rows
```
