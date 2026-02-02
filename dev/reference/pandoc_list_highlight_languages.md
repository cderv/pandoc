# List supported languages for Pandoc syntax highlighting

This function is useful to retrieve the supported languages by Pandoc's
syntax highlighter. These are the values that can be used as fenced code
attributes to trigger the highlighting of the block for the requested
language. See [`fenced_code_attributes` extensions
flag](https://pandoc.org/MANUAL.html#extension-fenced_code_attributes).

## Usage

``` r
pandoc_list_highlight_languages(version = "default")
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

a character vector of supported languages to use as fenced code
attributes.

## Examples

``` r
pandoc_list_highlight_languages()
#>   [1] "abc"             "actionscript"    "ada"             "agda"           
#>   [5] "apache"          "asn1"            "asp"             "ats"            
#>   [9] "awk"             "bash"            "bibtex"          "boo"            
#>  [13] "c"               "changelog"       "clojure"         "cmake"          
#>  [17] "coffee"          "coldfusion"      "comments"        "commonlisp"     
#>  [21] "cpp"             "cs"              "css"             "curry"          
#>  [25] "d"               "dart"            "debiancontrol"   "default"        
#>  [29] "diff"            "djangotemplate"  "dockerfile"      "dosbat"         
#>  [33] "dot"             "doxygen"         "doxygenlua"      "dtd"            
#>  [37] "eiffel"          "elixir"          "elm"             "email"          
#>  [41] "erlang"          "fasm"            "fortranfixed"    "fortranfree"    
#>  [45] "fsharp"          "gap"             "gcc"             "glsl"           
#>  [49] "gnuassembler"    "go"              "graphql"         "groovy"         
#>  [53] "hamlet"          "haskell"         "haxe"            "html"           
#>  [57] "idris"           "ini"             "isocpp"          "j"              
#>  [61] "java"            "javadoc"         "javascript"      "javascriptreact"
#>  [65] "json"            "jsp"             "julia"           "kotlin"         
#>  [69] "latex"           "lex"             "lilypond"        "literatecurry"  
#>  [73] "literatehaskell" "llvm"            "lua"             "m4"             
#>  [77] "makefile"        "mandoc"          "markdown"        "mathematica"    
#>  [81] "matlab"          "maxima"          "mediawiki"       "metafont"       
#>  [85] "mips"            "modelines"       "modula2"         "modula3"        
#>  [89] "monobasic"       "mustache"        "nasm"            "nim"            
#>  [93] "nix"             "noweb"           "objectivec"      "objectivecpp"   
#>  [97] "ocaml"           "octave"          "opencl"          "orgmode"        
#> [101] "pascal"          "perl"            "php"             "pike"           
#> [105] "postscript"      "povray"          "powershell"      "prolog"         
#> [109] "protobuf"        "pure"            "purebasic"       "purescript"     
#> [113] "python"          "qml"             "r"               "raku"           
#> [117] "relaxng"         "relaxngcompact"  "rest"            "rhtml"          
#> [121] "roff"            "ruby"            "rust"            "sass"           
#> [125] "scala"           "scheme"          "sci"             "scss"           
#> [129] "sed"             "sgml"            "sml"             "spdxcomments"   
#> [133] "sql"             "sqlmysql"        "sqlpostgresql"   "stan"           
#> [137] "stata"           "swift"           "systemverilog"   "tcl"            
#> [141] "tcsh"            "texinfo"         "toml"            "typescript"     
#> [145] "verilog"         "vhdl"            "xml"             "xorg"           
#> [149] "xslt"            "xul"             "yacc"            "yaml"           
#> [153] "zsh"            
if (FALSE) { # pandoc::pandoc_is_installed("2.11.4")
# check languages available in a specific Pandoc's version
pandoc_list_highlight_languages("2.11.4")
}
```
