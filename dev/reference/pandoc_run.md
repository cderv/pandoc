# Run the pandoc binary from R

This function is a thin wrapper around the pandoc binary and allow to
pass any arguments supported by the Pandoc binary.

## Usage

``` r
pandoc_run(args, version = "default")
```

## Arguments

- args:

  Character vector, arguments to the pandoc CLI command

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

The output of running `pandoc` binary

## Examples

``` r
# Run any command line argument (prefer `pandoc_convert()` for conversion )
pandoc::pandoc_run(c("--version"))
#> [1] "pandoc 3.1.11"                                                              
#> [2] "Features: +server +lua"                                                     
#> [3] "Scripting engine: Lua 5.4"                                                  
#> [4] "User data directory: /home/runner/.local/share/pandoc"                      
#> [5] "Copyright (C) 2006-2023 John MacFarlane. Web: https://pandoc.org"           
#> [6] "This is free software; see the source for copying conditions. There is no"  
#> [7] "warranty, not even for merchantability or fitness for a particular purpose."
pandoc::pandoc_run(c("--list-input-formats"), version = "system")
#>  [1] "biblatex"          "bibtex"            "bits"             
#>  [4] "commonmark"        "commonmark_x"      "creole"           
#>  [7] "csljson"           "csv"               "docbook"          
#> [10] "docx"              "dokuwiki"          "endnotexml"       
#> [13] "epub"              "fb2"               "gfm"              
#> [16] "haddock"           "html"              "ipynb"            
#> [19] "jats"              "jira"              "json"             
#> [22] "latex"             "man"               "markdown"         
#> [25] "markdown_github"   "markdown_mmd"      "markdown_phpextra"
#> [28] "markdown_strict"   "mediawiki"         "muse"             
#> [31] "native"            "odt"               "opml"             
#> [34] "org"               "ris"               "rst"              
#> [37] "rtf"               "t2t"               "textile"          
#> [40] "tikiwiki"          "tsv"               "twiki"            
#> [43] "typst"             "vimwiki"          
```
