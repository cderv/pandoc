#' Retrieve Pandoc template for a format
#'
#' This correspond to the [`--print-default-template` CLI
#' flag](https://pandoc.org/MANUAL.html#option--print-default-template). With
#' this function, one can easily export default LaTeX template for example.
#'
#' @param format One of Pandoc format using a text template. (e.g html, latex, revealjs)
#' @param output Path where to save the file. If not provided, the default, template content will be print to the console.
#' @inheritParams pandoc_run
#'
#' @return If `output` is not provided, the content of the template will be
#'   printed and return as one string (invisibly). If `output` is provided, the file path of
#'   the output (invisibly).
#' @examplesIf pandoc::pandoc_available("2.7.1")
#' pandoc_export_template()
#' @examplesIf rlang::is_interactive()
#' \dontshow{
#' withr::local_dir(withr::local_tempdir())
#' }
#' pandoc_export_template("latex", output = "default.tex", version = "system")
#' @export
pandoc_export_template <- function(format = "markdown", output = NULL, version = "default") {
  # https://pandoc.org/releases.html#pandoc-2.7.1-2019-03-14
  pandoc_feature_requirement("2.7.1", version)
  preview <- FALSE
  if (is.null(output)) {
    output <- fs::file_temp()
    on.exit(unlink(output))
    preview <- TRUE
  }
  args <- c(
    "--output", shQuote(path.expand(output)),
    "--print-default-template", format
  )
  pandoc_run(args, version = version)
  if (preview) {
    content <- read_utf8(output)
    cat(content)
    return(invisible(content))
  }
  rlang::inform(c(v = paste0("Template written to ", output)))
  invisible(output)
}

#' Export Pandoc internal data file
#'
#' This correspond to the [`--print-default-data-file` CLI
#' flag](https://pandoc.org/MANUAL.html#option--print-default-data-file) using
#' also `--output` to write a export a data file built in Pandoc.
#'
#' `pandoc_export_reference_doc()` is a helper to quickly get the reference doc for
#' Word document (`reference.docx`) or Powerpoint document (`reference.pptx`)
#'
#' @param file One of data file name included in Pandoc (e.g `reference.pptx`, `styles.html`)
#' @param output Path where to export the file. Default to working directory
#'   with the same file name.
#' @inheritParams pandoc_run
#'
#' @return the `output` (invisibly) where export has been done
#'
#' @examplesIf rlang::is_interactive()
#' \dontshow{
#' withr::local_dir(withr::local_tempdir())
#' }
#' # export style.html file included in Pandoc HTML template
#' pandoc_export_data_file("styles.html", output = "custom.html")
#' # export css file used for epub by default
#' pandoc_export_data_file("epub.css")
#'
#' @export
pandoc_export_data_file <- function(file, output = file, version = "default") {
  if (rlang::is_missing(file)) {
    rlang::abort("Enter the data file from Pandoc you want to export.")
  }
  # https://pandoc.org/releases.html#pandoc-2.7.1-2019-03-14
  pandoc_feature_requirement("2.7.1", version)
  if (file == "styles.html") {
    # Special handling for pandoc
    # https://pandoc.org/MANUAL.html#option--print-default-template
    force(output)
    file <- "templates/styles.html"
  }
  args <- c(
    "--output", shQuote(path.expand(output)),
    "--print-default-data-file", file
  )
  pandoc_run(args, version = version)
  rlang::inform(c(v = paste0("Template written to ", output)))
  invisible(output)
}

#' @rdname pandoc_export_data_file
#' @param type one of `docx` or `pptx` depending on the reference doc to export.
#' @examplesIf pandoc::pandoc_available() && rlang::is_interactive()
#' \dontshow{
#' withr::local_dir(withr::local_tempdir())
#' }
#' pandoc_export_reference_doc("docx")
#' pandoc_export_reference_doc("pptx")
#' @examplesIf pandoc::pandoc_is_installed("2.11.4") && rlang::is_interactive()
#' \dontshow{
#' withr::local_dir(withr::local_tempdir())
#' }
#' pandoc_export_reference_doc("pptx", version = "2.11.4")
#' @export
pandoc_export_reference_doc <- function(type = c("docx", "pptx"), version = "default") {
  type <- rlang::arg_match(type)
  ref_doc <- fs::path_ext_set("reference", type)
  pandoc_export_data_file(ref_doc, ref_doc, version = version)
}

#' Export highlighting style as JSON file
#'
#' Pandoc highlighting can be customize using a JSON `.theme` file, passed to
#' [`--highlight-style=`
#' flag](https://pandoc.org/MANUAL.html#option--highlight-style). This function
#' allows to generate the JSON version of one of the supported highlighting
#' style.
#'
#' The `.theme` extension is required and it will be enforced in during the
#' export by this function.
#'
#' @note This correspond to the [`--print-highlight-style` CLI
#' flag](https://pandoc.org/MANUAL.html#option--print-highlight-style) using
#' also `--output` to write a export a data file built in Pandoc.
#'
#' @param style One of the support highlighting style. (See [pandoc_list_highlight_style()]).
#' @param output Path (without extension) where to export the JSON `.theme`
#'   file. By default, the file will be located in working directory and named
#'   based on the parameter `style` (i.e `<style>.theme`).
#' @inheritParams pandoc_run
#'
#' @return the filename where the theme has been exported.
#' @examplesIf rlang::is_interactive()
#' \dontshow{
#' withr::local_dir(withr::local_tempdir())
#' }
#' # export tango theme used by Pandoc highlighting to `tango.theme` file
#' pandoc_export_highlight_theme("tango")
#' pandoc_export_highlight_theme("pygments", output = "my_theme.theme")
#' pandoc_export_highlight_theme("zenburn", version = "system")
#' @export
pandoc_export_highlight_theme <- function(style = "pygments", output = style, version = "default") {
  # https://pandoc.org/releases.html#pandoc-2.7.1-2019-03-14
  pandoc_feature_requirement("2.7.1", version)
  style <- rlang::arg_match(style, pandoc_list_highlight_style(version = version))
  if (!fs::path_ext(output) %in% c("", "theme")) {
    rlang::warn("`output` extension must be `.theme` and it will be enforced.")
  }
  output <- fs::path_ext_set(output, ".theme")
  args <- c(
    "--output", shQuote(path.expand(output)),
    "--print-highlight-style", style
  )
  pandoc_run(args, version = version)
  rlang::inform(c(v = paste0("Style written to ", output)))
  invisible(output)
}
