# pandoc

**pandoc** is currently an experimental R package primarily develop to
help maintainers of R Markdown ecosystem.

Indeed, the R Markdown ecosystem is highly dependent on Pandoc
(<https://pandoc.org/>) changes and it is designed to be as version
independent as possible. R Markdown is best used with the latest Pandoc
version but any **rmarkdown** package version should work with previous
version of Pandoc, and new change in Pandoc should not break any
**rmarkdown** features.

This explains the needs for a more focused tooling to:

- Install and manage several Pandoc versions. This is useful for testing
  versions and comparing between them.
- Call Pandoc’s command directly without the layers added by
  **rmarkdown**. This is useful for debugging or quickly iterating and
  finding where a bug comes from.
- Retrieve information from Pandoc directly. Each version comes with
  changes and some of them are included into the binary. Being able to
  retrieve those information and compare between versions is important
  to help maintain the user exposed tooling.

This package can also be useful to advanced developers that are working
around Pandoc through **rmarkdown** or not.

## Installation

Install from CRAN:

``` r
install.packages("pandoc")
```

The development version can be install from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("cderv/pandoc")
```

``` r
library(pandoc)
```

## Install pandoc

Main usage is to install **latest** released version of Pandoc. This
requires the [`gh`](https://github.com/r-lib/gh) package as it will
fetch information from Github and download the bundle from there.

``` r
pandoc_install()
#> ℹ Fetching Pandoc releases info from github...
#> ✔ Pandoc 3.8.3 already installed.
#>   Use 'force = TRUE' to overwrite.
```

If a specific older Pandoc version is needed (e.g for testing
differences between version), a version can be specified.

``` r
pandoc_install("2.11.4")
#> ✔ Pandoc 2.11.4 already installed.
#>   Use 'force = TRUE' to overwrite.
```

Information fetched from Github are cached for the duration of the
session.

Sometimes, the dev version of Pandoc is required. Pandoc’s team is
building a binary every day called *nightly* in there CI.

``` r
# install the nightly version (overwrites previous one)
pandoc_install_nightly() # or pandoc_install("nightly")
#> ℹ Retrieving last available nightly informations...
#> ℹ Installing last available nightly...
#>   Downloading bundle...
#> ✔ Last Pandoc nightly installed: 8efe9bcb4aeb399ded52205bbc96b499c4e66121
```

All those versions can live together and are installed in an isolated
directory in user’s data folders.

``` r
# Which version are currently installed ?
pandoc_installed_versions()
#>   [1] "nightly"  "3.8.3"    "3.8.2.1"  "3.8.2"    "3.8.1"    "3.8"     
#>   [7] "3.7.0.2"  "3.7.0.1"  "3.7"      "3.6.4"    "3.6.3"    "3.6.2"   
#>  [13] "3.6.1"    "3.6"      "3.5"      "3.4"      "3.3"      "3.2.1"   
#>  [19] "3.2"      "3.1.13"   "3.1.12.3" "3.1.12.2" "3.1.12.1" "3.1.12"  
#>  [25] "3.1.11.1" "3.1.11"   "3.1.10"   "3.1.9"    "3.1.8"    "3.1.7"   
#>  [31] "3.1.6.2"  "3.1.6.1"  "3.1.6"    "3.1.5"    "3.1.4"    "3.1.3"   
#>  [37] "3.1.2"    "3.1.1"    "3.1"      "3.0.1"    "3.0"      "2.19.2"  
#>  [43] "2.19.1"   "2.19"     "2.18"     "2.17.1.1" "2.17.1"   "2.17.0.1"
#>  [49] "2.17"     "2.16.2"   "2.16.1"   "2.16"     "2.15"     "2.14.2"  
#>  [55] "2.14.1"   "2.14.0.3" "2.14.0.2" "2.14.0.1" "2.14"     "2.13"    
#>  [61] "2.12"     "2.11.4"   "2.11.3.2" "2.11.3.1" "2.11.3"   "2.11.2"  
#>  [67] "2.11.1.1" "2.11.1"   "2.11.0.4" "2.11.0.2" "2.11.0.1" "2.11"    
#>  [73] "2.10.1"   "2.10"     "2.9.2.1"  "2.9.2"    "2.9.1.1"  "2.9.1"   
#>  [79] "2.9"      "2.8.1"    "2.8.0.1"  "2.8"      "2.7.3"    "2.7.2"   
#>  [85] "2.7.1"    "2.7"      "2.6"      "2.5"      "2.4"      "2.3.1"   
#>  [91] "2.3"      "2.2.3.2"  "2.2.3.1"  "2.2.2.1"  "2.2.2"    "2.2.1"   
#>  [97] "2.2"      "2.1.3"    "2.1.2"    "2.1.1"    "2.1"      "2.0.6"   
#> [103] "2.0.5"    "2.0.4"    "2.0.3"
# Which is the latest version installed (nightly excluded)?
pandoc_installed_latest()
#> [1] "3.8.3"
# Is a specific version installed ?
pandoc_is_installed("2.11.4")
#> [1] TRUE
pandoc_is_installed("2.7.3")
#> [1] TRUE
```

Downloaded bundles are also cached to speed up further installation.
This is useful into tests to quickly install and uninstall a pandoc
version for a specific test.

``` r
pandoc_install("2.7.3")
#> ✔ Pandoc 2.7.3 already installed.
#>   Use 'force = TRUE' to overwrite.
pandoc_uninstall("2.7.3")
pandoc_install("2.7.3")
#> ℹ Installing Pandoc release 2.7.3
#>   Downloading bundle...
#> ✔ Pandoc version 2.7.3 installed.
```

To quickly install the last available release, run
[`pandoc_update()`](https://cderv.github.io/pandoc/dev/reference/pandoc_install.md)
(alias of
[`pandoc_install()`](https://cderv.github.io/pandoc/dev/reference/pandoc_install.md)which
already default to latest version).

## Find where a pandoc binary is located

For any version installed with this package,
[`pandoc_locate()`](https://cderv.github.io/pandoc/dev/reference/pandoc_locate.md)
will return the folder where it was installed.

``` r
pandoc_locate("2.11.4")
#> [1] "~/.local/share/r-pandoc/2.11.4"
pandoc_locate("nightly")
#> [1] "~/.local/share/r-pandoc/nightly"
```

For example purposes in this vignette, the path above is in a temp
directory. Correct location is in user’s data directory computed with
[`rappdirs::user_data_dir()`](https://rappdirs.r-lib.org/reference/user_data_dir.html)
(e.g on Windows `C:/Users/chris/AppData/Local/r-pandoc/r-pandoc`)

To get the path to a pandoc binary,
[`pandoc_bin()`](https://cderv.github.io/pandoc/dev/reference/pandoc_bin.md)
can be used

``` r
pandoc_bin("2.11.4")
#> ~/.local/share/r-pandoc/2.11.4/pandoc
pandoc_bin("nightly")
#> ~/.local/share/r-pandoc/nightly/pandoc
```

This function also brings support for external pandoc version, like

- the one shipped with RStudio IDE (`version = "rstudio")`:
  - `pandoc::pandoc_bin("rstudio")` or alias
    [`pandoc::pandoc_rstudio_bin()`](https://cderv.github.io/pandoc/dev/reference/rstudio_pandoc.md)
- the one set by default on the system (in PATH) (`version = "system"`):
  - `pandoc::pandoc_bin("system")` or alias
    [`pandoc::pandoc_system_bin()`](https://cderv.github.io/pandoc/dev/reference/system_pandoc.md)

## Activate a Pandoc version

As multiple versions can be installed, a default active pandoc version
will be used with any of the function. (`version = "default"`).

A specific version can be made active using
[`pandoc_activate()`](https://cderv.github.io/pandoc/dev/reference/pandoc_activate.md)

``` r
# Default to latest version installed
pandoc_activate()
#> ✔ Version '3.8.3' is now the active one.
#> ℹ Pandoc version also activated for rmarkdown functions.
pandoc_locate()
#> [1] "~/.local/share/r-pandoc/3.8.3"
pandoc_bin()
#> ~/.local/share/r-pandoc/3.8.3/pandoc

# Activate specific version
pandoc_activate("2.11.4")
#> ✔ Version '2.11.4' is now the active one.
#> ℹ Pandoc version also activated for rmarkdown functions.
pandoc_locate()
#> [1] "~/.local/share/r-pandoc/2.11.4"
pandoc_bin()
#> ~/.local/share/r-pandoc/2.11.4/pandoc

# including nightly
pandoc_activate("nightly")
#> ✔ Version 'nightly' is now the active one.
#> ℹ Pandoc version also activated for rmarkdown functions.
pandoc_locate()
#> [1] "~/.local/share/r-pandoc/nightly"
pandoc_bin()
#> ~/.local/share/r-pandoc/nightly/pandoc

# Activate system version
pandoc_activate("system")
#> ✔ Version 'system' is now the active one.
#> ℹ Pandoc version also activated for rmarkdown functions.
pandoc_bin()
#> /opt/hostedtoolcache/pandoc/3.1.11/x64/pandoc
```

A default active version will be set when the package is loaded (i.e
using `onLoad`) following this search order:

- Latest version install by this package (i.e
  [`pandoc_installed_latest()`](https://cderv.github.io/pandoc/dev/reference/pandoc_installed_versions.md))
- Version shipped with RStudio IDE (found when run inside RStudio IDE)
- pandoc binary found in system PATH (i.e `Sys.which("pandoc")`)

[`pandoc_is_active()`](https://cderv.github.io/pandoc/dev/reference/pandoc_is_active.md)
allows to easily know if a specific version is active or not.

``` r
pandoc_is_active("system")
#> [1] TRUE
pandoc_is_active("2.7.3")
#> [1] FALSE
pandoc_activate("2.7.3")
#> ✔ Version '2.7.3' is now the active one.
#> ℹ Pandoc version also activated for rmarkdown functions.
pandoc_is_active("2.7.3")
#> [1] TRUE
```

### Working with **rmarkdown** functions related to Pandoc

By default, if **rmarkdown** is installed,
[`pandoc_activate()`](https://cderv.github.io/pandoc/dev/reference/pandoc_activate.md)
will also set the version active for all **rmarkdown** functions (using
[`rmarkdown::find_pandoc()`](https://pkgs.rstudio.com/rmarkdown/reference/find_pandoc.html)).
This allows to use this package easily in order to test **rmarkdown**
with different version of Pandoc.

``` r
pandoc_activate("2.7.3")
#> ✔ Version '2.7.3' is now the active one.
#> ℹ Pandoc version also activated for rmarkdown functions.
rmarkdown::pandoc_available()
#> [1] TRUE
rmarkdown::pandoc_version()
#> [1] '2.7.3'
rmarkdown::find_pandoc()
#> $version
#> [1] '2.7.3'
#> 
#> $dir
#> [1] "/home/runner/.local/share/r-pandoc/2.7.3"
```

These calls are equivalent:

``` r
pandoc_activate("2.7.3", rmarkdown = TRUE)
#> ✔ Version '2.7.3' is now the active one.
#> ℹ Pandoc version also activated for rmarkdown functions.
rmarkdown::find_pandoc(cache = FALSE, dir = pandoc::pandoc_locate("2.7.3"))
#> $version
#> [1] '2.7.3'
#> 
#> $dir
#> [1] "/home/runner/.local/share/r-pandoc/2.7.3"
```

If setting the default Pandoc version for **rmarkdown** is not desired,
just run with `rmarkdown = FALSE`

``` r
pandoc::pandoc_activate("2.11.4", rmarkdown = FALSE)
#> ✔ Version '2.11.4' is now the active one.
rmarkdown::pandoc_version()
#> [1] '2.7.3'
```

During testing, it also interesting to run a specific code with a
specific version.
[`with_pandoc_version()`](https://cderv.github.io/pandoc/dev/reference/with_pandoc_version.md)
or
[`local_pandoc_version()`](https://cderv.github.io/pandoc/dev/reference/with_pandoc_version.md)
allows by running
[`pandoc_activate()`](https://cderv.github.io/pandoc/dev/reference/pandoc_activate.md)
for the expression only (helper like [withr](https://withr.r-lib.org/)).

``` r
# with pandoc package functions
with_pandoc_version("2.11.4", {
  pandoc::pandoc_version()
})
#> [1] '2.11.4'

# with rmarkdown package functions
rmarkdown::pandoc_version()
#> [1] '2.11.4'

# It will also activate version for rmarkdown
with_pandoc_version("2.11.4", {
  rmarkdown::pandoc_version()
})
#> [1] '2.11.4'

# rmarkdown = FALSE can be set if not desired
with_pandoc_version("2.11.4", rmarkdown = FALSE, {
  rmarkdown::pandoc_version()
})
#> [1] '2.11.4'
```

Default behavior for
[`local_pandoc_version()`](https://cderv.github.io/pandoc/dev/reference/with_pandoc_version.md)
and
[`with_pandoc_version()`](https://cderv.github.io/pandoc/dev/reference/with_pandoc_version.md)
is determined by option `pandoc.activate_rmarkdown`.

### Check if a pandoc version is available

Is a pandoc version available to use (i.e a version is active), and if
so what is the full path ?

``` r
if (pandoc_available()) pandoc_bin()
#> ~/.local/share/r-pandoc/2.11.4/pandoc
```

Is the pandoc activated meeting some requirements ?

``` r
# Is the active version above 2.10.1 ?
pandoc_available(min = "2.10.1")
#> [1] TRUE
# Is the active version below 2.11 ?
pandoc_available(max = "2.11")
#> [1] FALSE
# Is the active version between 2.10.1 and 2.11, both side include ?
pandoc_available(min = "2.10.1", max = "2.11")
#> [1] FALSE
```

Pandoc version can also easily be retrieved, including for external
binaries

``` r
# Get version from current active one
pandoc_version()
#> [1] '2.11.4'
# Get version for a specific version
pandoc_version("nightly")
#> [1] '3.8.3.9999'
# Get version for a specific version
pandoc_version("system") # equivalent to pandoc_system_version()
#> [1] '3.1.11'
```

## Run Pandoc CLI from R

### Low level call to Pandoc

[`pandoc_run()`](https://cderv.github.io/pandoc/dev/reference/pandoc_run.md)
is the function to call pandoc binary with some arguments. By default,
it will use the active version (`version = "default"`, see
[`?pandoc_activate`](https://cderv.github.io/pandoc/dev/reference/pandoc_activate.md))

``` r
pandoc_run("--version")
#> [1] "pandoc 2.11.4"                                                                
#> [2] "Compiled with pandoc-types 1.22, texmath 0.12.1, skylighting 0.10.2,"         
#> [3] "citeproc 0.3.0.5, ipynb 0.1.0.1"                                              
#> [4] "User data directory: /home/runner/.local/share/pandoc or /home/runner/.pandoc"
#> [5] "Copyright (C) 2006-2021 John MacFarlane. Web:  https://pandoc.org"            
#> [6] "This is free software; see the source for copying conditions. There is no"    
#> [7] "warranty, not even for merchantability or fitness for a particular purpose."
```

equivalent to calling

``` bash
pandoc --version
```

with the correct binary.

Using the `version=` argument allows to run a specific version

``` r
pandoc_run("--version", version = "system")
```

will execute the pandoc command with pandoc binary on PATH.

### Convert a document

> This function is highly experimental and probability of API change is
> high.

Main usage of Pandoc is to convert a document. The
[`pandoc::pandoc_convert()`](https://cderv.github.io/pandoc/dev/reference/pandoc_convert.md)
is currently a thinner wrapper than
[`rmarkdown::pandoc_convert()`](https://pkgs.rstudio.com/rmarkdown/reference/pandoc_convert.html).
Both allow to convert a file but the former also allow to convert from
text and not just a file.

``` r
# convert from text directly
pandoc_convert(text = "# A header", to = "html")
#> <h1 id="a-header">A header</h1>
pandoc_convert(text = "# A header", to = "html", version = "system")
#> <h1 id="a-header">A header</h1>

# convert from file
tmp <- tempfile(fileext = ".md")
writeLines("**bold** word!", tmp)
pandoc_convert(tmp, to = "html")
#> <p><strong>bold</strong> word!</p>
# write to file
out <- tempfile(fileext = ".html")
outfile <- pandoc_convert(tmp, to = "html", output = out, standalone = TRUE, version = "system")
readLines(outfile, n = 5)
#> [1] "<!DOCTYPE html>"                                                      
#> [2] "<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"\" xml:lang=\"\">"
#> [3] "<head>"                                                               
#> [4] "  <meta charset=\"utf-8\" />"                                         
#> [5] "  <meta name=\"generator\" content=\"pandoc\" />"
```

### Various Wrapper functions around pandoc CLI

All other included functions to run pandoc are wrapping
[`pandoc_run()`](https://cderv.github.io/pandoc/dev/reference/pandoc_run.md)
with some command flags from [Pandoc
MANUAL](https://pandoc.org/MANUAL.html). Each of these functions can
take the `version=` argument to run with a specific version of Pandoc
instead of the current activated one.

Some of those functions can only be used with specific pandoc versions
and an error will be thrown if the version requirement is not met.

#### List supported extensions for a format

``` r
pandoc_list_extensions()
#> # A tibble: 68 × 3
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
#> # ℹ 58 more rows
pandoc_list_extensions(format = "gfm")
#> # A tibble: 26 × 3
#>    format extensions             default
#>    <chr>  <chr>                  <lgl>  
#>  1 gfm    ascii_identifiers      FALSE  
#>  2 gfm    autolink_bare_uris     TRUE   
#>  3 gfm    bracketed_spans        FALSE  
#>  4 gfm    definition_lists       FALSE  
#>  5 gfm    east_asian_line_breaks FALSE  
#>  6 gfm    emoji                  TRUE   
#>  7 gfm    fancy_lists            FALSE  
#>  8 gfm    fenced_code_attributes FALSE  
#>  9 gfm    fenced_divs            FALSE  
#> 10 gfm    footnotes              FALSE  
#> # ℹ 16 more rows
pandoc_list_extensions(format = "html", version = "nightly")
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

#### List available input or output formats

``` r
pandoc_list_formats("input")
#> # A tibble: 38 × 2
#>    type  formats     
#>    <chr> <chr>       
#>  1 input biblatex    
#>  2 input bibtex      
#>  3 input commonmark  
#>  4 input commonmark_x
#>  5 input creole      
#>  6 input csljson     
#>  7 input csv         
#>  8 input docbook     
#>  9 input docx        
#> 10 input dokuwiki    
#> # ℹ 28 more rows
pandoc_list_formats("output")
#> # A tibble: 61 × 2
#>    type   formats     
#>    <chr>  <chr>       
#>  1 output asciidoc    
#>  2 output asciidoctor 
#>  3 output beamer      
#>  4 output biblatex    
#>  5 output bibtex      
#>  6 output commonmark  
#>  7 output commonmark_x
#>  8 output context     
#>  9 output csljson     
#> 10 output docbook     
#> # ℹ 51 more rows
pandoc_list_formats("output", version = "nightly")
#> # A tibble: 75 × 2
#>    type   formats        
#>    <chr>  <chr>          
#>  1 output ansi           
#>  2 output asciidoc       
#>  3 output asciidoc_legacy
#>  4 output asciidoctor    
#>  5 output bbcode         
#>  6 output bbcode_fluxbb  
#>  7 output bbcode_hubzilla
#>  8 output bbcode_phpbb   
#>  9 output bbcode_steam   
#> 10 output bbcode_xenforo 
#> # ℹ 65 more rows
```

#### List available highlight style

``` r
pandoc_list_highlight_style()
#> [1] "pygments"   "tango"      "espresso"   "zenburn"    "kate"      
#> [6] "monochrome" "breezedark" "haddock"
```

#### List supported highlight language

``` r
pandoc_list_highlight_languages()
#>   [1] "abc"             "actionscript"    "ada"             "agda"           
#>   [5] "apache"          "asn1"            "asp"             "ats"            
#>   [9] "awk"             "bash"            "bibtex"          "boo"            
#>  [13] "c"               "changelog"       "clojure"         "cmake"          
#>  [17] "coffee"          "coldfusion"      "comments"        "commonlisp"     
#>  [21] "cpp"             "cs"              "css"             "curry"          
#>  [25] "d"               "default"         "diff"            "djangotemplate" 
#>  [29] "dockerfile"      "dot"             "doxygen"         "doxygenlua"     
#>  [33] "dtd"             "eiffel"          "elixir"          "elm"            
#>  [37] "email"           "erlang"          "fasm"            "fortranfixed"   
#>  [41] "fortranfree"     "fsharp"          "gcc"             "glsl"           
#>  [45] "gnuassembler"    "go"              "graphql"         "groovy"         
#>  [49] "hamlet"          "haskell"         "haxe"            "html"           
#>  [53] "idris"           "ini"             "isocpp"          "j"              
#>  [57] "java"            "javadoc"         "javascript"      "javascriptreact"
#>  [61] "json"            "jsp"             "julia"           "kotlin"         
#>  [65] "latex"           "lex"             "lilypond"        "literatecurry"  
#>  [69] "literatehaskell" "llvm"            "lua"             "m4"             
#>  [73] "makefile"        "mandoc"          "markdown"        "mathematica"    
#>  [77] "matlab"          "maxima"          "mediawiki"       "metafont"       
#>  [81] "mips"            "modelines"       "modula2"         "modula3"        
#>  [85] "monobasic"       "mustache"        "nasm"            "nim"            
#>  [89] "noweb"           "objectivec"      "objectivecpp"    "ocaml"          
#>  [93] "octave"          "opencl"          "pascal"          "perl"           
#>  [97] "php"             "pike"            "postscript"      "povray"         
#> [101] "powershell"      "prolog"          "protobuf"        "pure"           
#> [105] "purebasic"       "python"          "qml"             "r"              
#> [109] "relaxng"         "relaxngcompact"  "rest"            "rhtml"          
#> [113] "roff"            "ruby"            "rust"            "scala"          
#> [117] "scheme"          "sci"             "sed"             "sgml"           
#> [121] "sml"             "spdxcomments"    "sql"             "sqlmysql"       
#> [125] "sqlpostgresql"   "stata"           "tcl"             "tcsh"           
#> [129] "texinfo"         "toml"            "typescript"      "verilog"        
#> [133] "vhdl"            "xml"             "xorg"            "xslt"           
#> [137] "xul"             "yacc"            "yaml"            "zsh"
```

#### Export a data file

``` r
outfile <- pandoc_export_data_file(file = "styles.html")
#> ✔ Template written to styles.html
outfile
#> [1] "styles.html"
readLines(outfile, n = 5)
#> [1] "$if(document-css)$"                                                 
#> [2] "html {"                                                             
#> [3] "  line-height: $if(linestretch)$$linestretch$$else$1.5$endif$;"     
#> [4] "  font-family: $if(mainfont)$$mainfont$$else$Georgia, serif$endif$;"
#> [5] "  font-size: $if(fontsize)$$fontsize$$else$20px$endif$;"
```

#### Export a highlight style JSON file

``` r
outfile <- pandoc_export_highlight_theme(style = "zenburn")
#> ✔ Style written to zenburn.theme
outfile
#> zenburn.theme
readLines(outfile, n = 5)
#> [1] "{"                                          
#> [2] "    \"text-color\": \"#cccccc\","           
#> [3] "    \"background-color\": \"#303030\","     
#> [4] "    \"line-number-color\": null,"           
#> [5] "    \"line-number-background-color\": null,"
```

#### Export a DOCX or PTTX reference doc

``` r
ref_docx <- pandoc_export_reference_doc(type = "docx")
#> ✔ Template written to reference.docx
ref_docx
#> reference.docx
ref_pptx <- pandoc_export_reference_doc(type = "pptx")
#> ✔ Template written to reference.pptx
ref_pptx
#> reference.pptx
```

#### Export a template for a format

``` r
pandoc_export_template(format = "jira")
#> $for(include-before)$
#> $include-before$
#> 
#> $endfor$
#> $body$
#> $for(include-after)$
#> 
#> $include-after$
#> $endfor$
outfile <- pandoc_export_template(format = "latex", output = "default.latex")
#> ✔ Template written to default.latex
outfile
#> [1] "default.latex"
readLines(outfile, n = 5)
#> [1] "% Options for packages loaded elsewhere"                                                  
#> [2] "\\PassOptionsToPackage{unicode$for(hyperrefoptions)$,$hyperrefoptions$$endfor$}{hyperref}"
#> [3] "\\PassOptionsToPackage{hyphens}{url}"                                                     
#> [4] "$if(colorlinks)$"                                                                         
#> [5] "\\PassOptionsToPackage{dvipsnames,svgnames*,x11names*}{xcolor}"
```

## Helpers to easily browse Pandoc’s online resources

`pandoc_browse_*()` helpers are included to quickly open an online
document like the Pandoc MANUAL
([`pandoc_browse_manual()`](https://cderv.github.io/pandoc/dev/reference/pandoc_browse_manual.md))
or a documentation for an extensions
(`pandoc_browse_extension("smart")`). See [reference
doc](https://cderv.github.io/pandoc/dev/articles/reference/dev/reference/index.html#section-browse-pandoc-s-useful-online-resources)
for more.
