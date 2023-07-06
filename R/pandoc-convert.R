#' Run Pandoc to convert a document or a text
#'
#' Main usage of Pandoc is to convert some text from a format into another.
#' This function will do just that:
#' * converting from a file or directly from text
#' * writing to a file or directly to console
#'
#' @param file,text One or the other should be provided
#' @param from Format to convert from. This must be one of the format supported
#'   by Pandoc. Default will be `markdown`. This correspond to the [`--from/-f`
#'   CLI flag](https://pandoc.org/MANUAL.html#option--from)
#' @param to Format to convert to. This must be one of the format supported by
#'   Pandoc. This correspond to the [`--to/-t` CLI
#'   flag](https://pandoc.org/MANUAL.html#option--to).
#' @param output Pass a path to a file to write the result from Pandoc
#'   conversion into a file. This corresponds to the [`--output/-o`
#'   flag](https://pandoc.org/MANUAL.html#option--output)
#' @param standalone Should appropriate header and footer be included ?
#'   This corresponds to [`--standalone/-s`
#'   CLI flag](https://pandoc.org/MANUAL.html#option--standalone)
#' @param args Any other flag supported by Pandoc CLI. See
#'   <https://pandoc.org/MANUAL.html#options>
#' @inheritParams pandoc_run
#'
#' @return `output` is provided, the absolute file path. If not, the output of
#'   `pandoc` binary run.
#'
#' @examplesIf pandoc::pandoc_available()
#' pandoc::pandoc_convert(text = "_This will be emphasize_", to = "latex")
#' @examplesIf pandoc::pandoc_is_installed("2.11.4")
#' pandoc::pandoc_convert(text = "**This will be bold**", to = "html", version = "2.11.4")
#' @export
pandoc_convert <- function(file = NULL,
                           text = NULL,
                           from = "markdown",
                           to,
                           output = NULL,
                           standalone = FALSE,
                           args = c(),
                           version = "default") {
  if (!is.null(file) && !is.null(text)) {
    rlang::abort(c("x" = "Only 'file' or 'text' can be used."))
  }
  if (!is.null(text)) {
    file <- fs::file_temp()
    on.exit(unlink(file))
    text <- paste0(text, collapse = "\n")
    write_utf8(text, file)
  }
  args <- c(
    "--from", from,
    "--to", to,
    if (standalone) "--standalone",
    if (!is.null(output)) c("--output", shQuote(output)),
    args,
    shQuote(file)
  )

  res <- pandoc_run(args, version = version)

  if (!is.null(output)) {
    return(fs::path_abs(output))
  }

  class(res) <- c("pandoc_raw_result", class(res))
  res
}

#' @export
print.pandoc_raw_result <- function(x, ...) {
  if (!rlang::is_empty(x)) {
    cat(x, sep = "\n")
  }
  invisible(x)
}
