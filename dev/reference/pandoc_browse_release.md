# Open Pandoc's release page in browser

Open Pandoc's release page in browser

## Usage

``` r
pandoc_browse_release(version = "latest")
```

## Arguments

- version:

  One of pandoc release version number (e.g '2.11.2') or `"latest"`.

## Value

Open the web page in browser in interactive mode or print the url

## References

<https://github.com/jgm/pandoc/releases>

## Examples

``` r
if (FALSE) { # rlang::is_interactive() && rlang::is_installed("gh") && attr(curlGetHeaders("https://github.com"), "status") == "200"
pandoc_browse_release()
pandoc_browse_release("2.14")
}
```
