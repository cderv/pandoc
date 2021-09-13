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
#' @export
pandoc_get_template <- function(format = "markdown", output = NULL, version = "default") {

  preview <- FALSE
  if (rlang::is_null(output)) {
    output <- fs::file_temp()
    on.exit(unlink(output))
    preview <- TRUE
  }
  args <- c(
    "--output", output,
    "--print-default-template", format)
  pandoc_run(args, version = version, echo = FALSE)
  if (preview) {
    content <- brio::read_file(output)
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
#' also `--output` to write a export a data file build in Pandoc.
#'
#' @param file One of data file name included in Pandoc (e.g `reference.pptx`, `styles.html`)
#' @param output Path where to export the file. Default to working directory
#'   with the same file name.
#' @inheritParams pandoc_run
#' @export
pandoc_get_data_file <- function(file, output = file, version = "default") {
  if (rlang::is_missing(file)) {
    rlang::abort("Enter the data file from Pandoc you want to export.")
  }
  args <- c(
    "--output", output,
    "--print-default-data-file", file)
  pandoc_run(args, version = version, echo = FALSE)
  rlang::inform(c(v = paste0("Template written to ", output)))
  invisible(output)
}
