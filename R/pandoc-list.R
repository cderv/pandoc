#' List available supported formats
#'
#' @param type Either list `input` or `output` formats. It corresponds to call
#'   `--list-input-formats` and `--list-output-formats` respectively.
#' @inheritParams pandoc_run
#'
#' @return a data.frame (or a tibble if available) with 2 colums:
#'    * `type` (input or output)
#'    * `formats` (name of the formats that can be used as input or output)
#'
#' @export
pandoc_list_formats <- function(type = c("input", "output"), bin = pandoc_bin()) {
  if (pandoc_version(bin) < "1.18") {
    rlang::abort(c("x" = "This feature is only available for Pandoc 1.18 and above."))
  }
  type <- rlang::arg_match(type)
  args <- switch(type,
                 input = "--list-input-formats",
                 output = "--list-output-formats")
  res <- pandoc_run(args, bin = bin, echo = FALSE)
  tmp_file <- fs::file_temp()
  on.exit(unlink(tmp_file))
  brio::write_file(res$stdout, tmp_file)
  formats <- brio::read_lines(tmp_file)
  formats_tbl <- data.frame(
    type = type,
    formats = formats
  )
  if (rlang::is_installed('tibble')) return(tibble::as_tibble(formats_tbl))
  formats_tbl
}

#' List supported extensions for a format
#'
#' Pandoc has a system of extensions to activate or deactivate some features.
#' Each format have a set of activated by default extensions and other supported
#' extensions than can be activated.
#'
#' All the extensions for the last Pandoc version released are available in
#' <https://pandoc.org/MANUAL.html>.
#'
#' @param format One for the supported  `input` or `output` formats. See [pandoc_list_formats()]. It corresponds to call
#' @inheritParams pandoc_run
#'
#' @return a data.frame (or a tibble if available) with 3 colums:
#'    * `format`: One of the Pandoc format
#'    * `extensions` : name of the extensions
#'    * `default`: Is the extensions activated by default or not ?
#'
#' @export
pandoc_list_extensions <- function(format = "markdown", bin = pandoc_bin()) {
  if (pandoc_version(bin) < "2.8") {
    rlang::abort(c("x" = "This feature is only available for Pandoc 2.8 and above."))
  }
  args <- c("--list-extensions", format)
  res <- pandoc_run(args, bin = bin, echo = FALSE)
  tmp_file <- tempfile()
  on.exit(unlink(tmp_file))
  brio::write_file(res$stdout, tmp_file)
  extensions <- brio::read_lines(tmp_file)
  extensions_tbl <- data.frame(
    format = format,
    extensions = gsub("^[-+]", "", extensions)
  )
  extensions_tbl$default <- ifelse(
    gsub("^([-+]{1}).*", "\\1", extensions_tbl$extensions) == "+",
    TRUE,
    FALSE
  )
  if (rlang::is_installed('tibble')) return(tibble::as_tibble(extensions_tbl))
  extensions_tbl
}
