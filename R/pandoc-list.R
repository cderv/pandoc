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
pandoc_list_formats <- function(type = c("input", "output"), version = "default") {
  if (pandoc_version(version = version) < "1.18") {
    rlang::abort(c("x" = "This feature is only available for Pandoc 1.18 and above."))
  }
  type <- rlang::arg_match(type)
  args <- switch(type,
                 input = "--list-input-formats",
                 output = "--list-output-formats")
  formats <- pandoc_run_to_file(args, version = version)
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
pandoc_list_extensions <- function(format = "markdown", version = "default") {
  if (pandoc_version(version = version) < "2.8") {
    rlang::abort(c("x" = "This feature is only available for Pandoc 2.8 and above."))
  }
  args <- c("--list-extensions", format)
  extensions <- pandoc_run_to_file(args, version = version)
  extensions_tbl <- data.frame(
    format = format,
    extensions = gsub("^[-+]", "", extensions)
  )
  extensions_tbl$default <- ifelse(
    gsub("^([-+]{1}).*", "\\1", extensions) == "+",
    TRUE,
    FALSE
  )
  if (rlang::is_installed('tibble')) return(tibble::as_tibble(extensions_tbl))
  extensions_tbl
}

#' List supported styles for Pandoc syntax highlighting
#'
#' Pandoc includes a highlighter which offer a styling mechanism to specify the
#' coloring style to be used in highlighted source code. This function returns
#' the supported values which can be specify at `pandoc` command line using the
#' [`--highlight-style=`
#' flag](https://pandoc.org/MANUAL.html#option--highlight-style).
#'
#' @inheritParams pandoc_run
#'
#' @return a character vector of supported highligting style name to use.
#'
#' @export
pandoc_list_highlight_style <- function(version = "default") {
  args <- c("--list-highlight-styles")
  pandoc_run_to_file(args, version = version)
}

#' List system default abbreviations
#'
#' Pandoc uses this list in the Markdown reader. Strings found in this list will
#' be followed by a nonbreaking space, and the period will not produce
#' sentence-ending space in formats like LaTeX. The strings may not contain
#' spaces.
#'
#' This correspond to the option [`--abbreviations` as CLI
#' flag](https://pandoc.org/MANUAL.html#option--abbreviations).
#'
#' @inheritParams pandoc_run
#'
#' @return a character version of system default abbreviation known by Pandoc
#' @export
pandoc_list_abbreviations <- function(version = "default") {
  args <- c("--print-default-data-file", "abbreviations")
  pandoc_run_to_file(args, version = version)
}
