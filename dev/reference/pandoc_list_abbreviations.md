# List system default abbreviations

Pandoc uses this list in the Markdown reader. Strings found in this list
will be followed by a non-breaking space, and the period will not
produce sentence-ending space in formats like LaTeX. The strings may not
contain spaces.

## Usage

``` r
pandoc_list_abbreviations(version = "default")
```

## Arguments

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

a character version of system default abbreviation known by Pandoc

## Details

This correspond to the option [`--abbreviations` as CLI
flag](https://pandoc.org/MANUAL.html#option--abbreviations).

## Examples

``` r
pandoc_list_abbreviations()
#>  [1] "aet."   "aetat." "al."    "Apr."   "Aug."   "bk."    "Bros."  "c."    
#>  [9] "Capt."  "cf."    "ch."    "chap."  "chs."   "Co."    "col."   "Corp." 
#> [17] "cp."    "d."     "Dec."   "Dr."    "e.g."   "ed."    "eds."   "esp."  
#> [25] "f."     "fasc."  "Feb."   "ff."    "fig."   "fl."    "fol."   "fols." 
#> [33] "Fr."    "Gen."   "Gov."   "Hon."   "i.e."   "ill."   "Inc."   "incl." 
#> [41] "Jan."   "Jr."    "Jul."   "Jun."   "Ltd."   "M.A."   "M.D."   "Mar."  
#> [49] "Mr."    "Mrs."   "Ms."    "n."     "n.b."   "nn."    "No."    "Nov."  
#> [57] "Oct."   "p."     "Ph.D."  "pp."    "Pres."  "Prof."  "pt."    "q.v."  
#> [65] "Rep."   "Rev."   "s.v."   "s.vv."  "saec."  "sec."   "Sen."   "Sep."  
#> [73] "Sept."  "Sgt."   "Sr."    "St."    "univ."  "viz."   "vol."   "vs."   
if (FALSE) { # pandoc::pandoc_is_installed("2.11.4")
# check abbreviations available in a specific Pandoc's version
pandoc_list_abbreviations("2.11.4")
}
```
