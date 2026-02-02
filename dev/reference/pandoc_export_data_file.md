# Export Pandoc internal data file

This correspond to the [`--print-default-data-file` CLI
flag](https://pandoc.org/MANUAL.html#option--print-default-data-file)
using also `--output` to write a export a data file built in Pandoc.

## Usage

``` r
pandoc_export_data_file(file, output = file, version = "default")

pandoc_export_reference_doc(type = c("docx", "pptx"), version = "default")
```

## Arguments

- file:

  One of data file name included in Pandoc (e.g `reference.pptx`,
  `styles.html`)

- output:

  Path where to export the file. Default to working directory with the
  same file name.

- version:

  Version to use. Default will be the `"default"` version. Other
  possible value are

  - A version number e.g `"2.14.1"`

  - The nightly version called `"nightly"`

  - The latest installed version with `"latest"`

  - Pandoc binary shipped with RStudio IDE with `"rstudio"`

  - Pandoc binary found in PATH with `"system"`

  - Pandoc binary shipped with Quarto CLI with `"quarto"`

- type:

  one of `docx` or `pptx` depending on the reference doc to export.

## Value

the `output` (invisibly) where export has been done

## Details

`pandoc_export_reference_doc()` is a helper to quickly get the reference
doc for Word document (`reference.docx`) or Powerpoint document
(`reference.pptx`)

## Examples

``` r
if (FALSE) { # rlang::is_interactive()
DONTSHOW({
withr::local_dir(withr::local_tempdir())
})
# export style.html file included in Pandoc HTML template
pandoc_export_data_file("styles.html", output = "custom.html")
# export css file used for epub by default
pandoc_export_data_file("epub.css")
}
if (FALSE) { # pandoc::pandoc_available() && rlang::is_interactive()
DONTSHOW({
withr::local_dir(withr::local_tempdir())
})
pandoc_export_reference_doc("docx")
pandoc_export_reference_doc("pptx")
}
if (FALSE) { # pandoc::pandoc_is_installed("2.11.4") && rlang::is_interactive()
DONTSHOW({
withr::local_dir(withr::local_tempdir())
})
pandoc_export_reference_doc("pptx", version = "2.11.4")
}
```
