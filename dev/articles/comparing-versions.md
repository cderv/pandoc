# Comparing Pandoc versions

One of the aim for this package is to help dealing with Pandoc changes
over time. Pandoc is a project which has often some breaking change
between versions. However, tools like R Markdown aims to work with any
Pandoc versions, and hide those changes for the user by insure backward
compatibility and adjustment toward new features.

Dealing with this can require to compare versions and now when a change
occurs.

## Use Case 1: Finding which version introduced a change

Let’s take the example of a change in Pandoc regarding `gfm` format: It
appears at some point that raw HTML `<span></span>` was removed during
conversion. When does this happened ? Let’s take a look.

For that, we want to convert `"This is a <span>Span</span>."` to `gfm`
format and look for the max version that keep the raw HTML `<span>` in
its markdown output.

``` r
library(pandoc)
```

As a prerequisite to the analysis, all available pandoc versions needs
to be installed.

``` r
purrr::walk(pandoc_available_releases(), purrr::safely(pandoc_install))
```

Once this is done, it is easy to iterate over versions to do an analysis
over an hypothesis.

First, we use each Pandoc version to convert
`"This is a <span>Span</span>."` to Github Markdown

``` r
# Get the available versions
versions <- pandoc_installed_versions()
versions <- purrr::set_names(versions)

# Do conversion for each version
res <- purrr::map(
  versions,
  ~ pandoc_convert(text = "This is a <span>Span</span>.", to = "gfm", version = .x)
)
```

With the result, we can build a tibble to filter out which is the
maximum version that preserve the raw `<span>`

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
tab <- res %>%
  purrr::map_chr(as.character) %>%
  tibble::enframe("ver", "string")

tab %>%
  # No nightly
  filter(ver != "nightly") %>%
  # converting to numeric version for easier ordering
  mutate(num_ver = as.numeric_version(ver)) %>%
  # Which version does keep <span> ?
  filter(grepl("<span>", string, fixed = TRUE)) %>%
  # Order version
  arrange(num_ver) %>%
  # which is the max one ?
  slice_tail(n = 1)
#> # A tibble: 1 × 3
#>   ver   string                       num_ver   
#>   <chr> <chr>                        <nmrc_vrs>
#> 1 2.10  This is a <span>Span</span>. 2.10
```

We can confirm looking at 2.10 and 2.10.1, that `<span>` is indeed not
preserve.

``` r
tab %>%
  filter(ver %in% c("2.10", "2.10.1"))
#> # A tibble: 2 × 2
#>   ver    string                      
#>   <chr>  <chr>                       
#> 1 2.10.1 This is a Span.             
#> 2 2.10   This is a <span>Span</span>.
```

From there, it is easier to know how to adapt, by first looking into the
changes in Pandoc’s release not

``` r
pandoc_browse_release("2.10.1")
#> ℹ Open URL
#> https://github.com/jgm/pandoc/releases/2.10.1
```

## Use Case 2: Which output formats has `--autolink_bare_uris` extensions available ?

To answer this question, it is interesting to be able to iterate over
all available formats, for a specific version. Let’s take version “2.17”
as example.

``` r
library(pandoc)
pandoc_install("2.17")
```

``` r
# Activating Pandoc version to use
pandoc_activate("2.17", rmarkdown = FALSE)
#> ✔ Version '2.17' is now the active one.

library(dplyr)
library(tidyr)
format_extensions <- pandoc_list_formats("output") %>%
  filter(!formats %in% c("pdf")) %>%
  group_by(formats) %>%
  mutate(exts = list(pandoc_list_extensions(formats))) %>%
  ungroup()

has_smart <- format_extensions %>%
  hoist(exts, "extensions", "default") %>%
  select(-exts) %>%
  unnest_longer(c("extensions", "default")) %>%
  filter(extensions == "smart")
```

Which has it by default ?

``` r
has_smart %>%
  filter(default)
#> # A tibble: 7 × 4
#>   type   formats      extensions default
#>   <chr>  <chr>        <chr>      <lgl>  
#> 1 output beamer       smart      TRUE   
#> 2 output commonmark_x smart      TRUE   
#> 3 output context      smart      TRUE   
#> 4 output latex        smart      TRUE   
#> 5 output markdown     smart      TRUE   
#> 6 output opml         smart      TRUE   
#> 7 output textile      smart      TRUE
```

Which does not ?

``` r
has_smart %>%
  filter(!default)
#> # A tibble: 17 × 4
#>    type   formats           extensions default
#>    <chr>  <chr>             <chr>      <lgl>  
#>  1 output commonmark        smart      FALSE  
#>  2 output epub              smart      FALSE  
#>  3 output epub2             smart      FALSE  
#>  4 output epub3             smart      FALSE  
#>  5 output gfm               smart      FALSE  
#>  6 output html              smart      FALSE  
#>  7 output html4             smart      FALSE  
#>  8 output html5             smart      FALSE  
#>  9 output ipynb             smart      FALSE  
#> 10 output markdown_github   smart      FALSE  
#> 11 output markdown_mmd      smart      FALSE  
#> 12 output markdown_phpextra smart      FALSE  
#> 13 output markdown_strict   smart      FALSE  
#> 14 output mediawiki         smart      FALSE  
#> 15 output org               smart      FALSE  
#> 16 output plain             smart      FALSE  
#> 17 output rst               smart      FALSE
```
