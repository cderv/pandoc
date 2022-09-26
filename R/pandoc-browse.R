# inspired from usethis::view_url
# https://github.com/r-lib/usethis/blob/1e6b70168064b1af453406b4a7c2eb7724b5a8de/R/helpers.R#L119
url_view <- function(...) {
  url <- paste(..., sep = "/")
  if (rlang::is_interactive()) {
    rlang::inform(c(v = "Opening URL", url))
    utils::browseURL(url)
  } else {
    rlang::inform(c(i = "Open URL", url))
  }
  invisible(url)
}

#' Open Pandoc's release page in browser
#'
#' @param version One of pandoc release version number (e.g '2.11.2') or `"latest"`.
#'
#' @references <https://github.com/jgm/pandoc/releases>
#'
#' @return Open the web page in browser in interactive mode or print the url
#' @examples
#' \dontshow{withr::local_options(list(rlang_interactive = FALSE))}
#' pandoc_browse_release()
#' pandoc_browse_release("2.14")
#' @export
pandoc_browse_release <- function(version = "latest") {
  # Don't offer to install gh here as it is not necessary
  if (rlang::is_installed("gh") &&
    !version %in% c("latest", pandoc_available_releases())) {
    rlang::abort(sprintf("Version '%s' is not a valid pandoc version", version))
  }
  url_view("https://github.com/jgm/pandoc/releases", version)
}

#' Open Pandoc's MANUAL
#'
#' @references <https://pandoc.org/MANUAL.html>
#'
#' @param id One of the id available in the HTML page (usually for anchor link).
#'
#' @return Open the Pandoc's MANUAL
#' @examples
#' \dontshow{withr::local_options(list(rlang_interactive = FALSE))}
#' # open MANUAL home page
#' pandoc_browse_manual()
#' # open MANUAL at math part
#' pandoc_browse_manual("math")
#' @export
pandoc_browse_manual <- function(id = NULL) {
  path <- "MANUAL.html"
  if (!is.null(id)) path <- paste0(path, "#", id)
  url_view("https://pandoc.org", path)
}

#' Open Pandoc's documentation about an extension
#'
#' @param extension One of the supported extension. See
#'   [pandoc_list_extensions()]. As the Pandoc MANUAL only concerns the last
#'   released Pandoc's version, if the URL is incorrect this could mean the
#'   extensions has changed.
#'
#' @return Open the webpage at the place regarding the required extension.
#' @examples
#' \dontshow{withr::local_options(list(rlang_interactive = FALSE))}
#' pandoc_browse_extension()
#' pandoc_browse_extension("auto_identifiers")
#' @export
pandoc_browse_extension <- function(extension = NULL) {
  id <- if (is.null(extension)) {
    "extensions"
  } else {
    paste0("extension-", extension)
  }
  pandoc_browse_manual(id)
}

#' Open Pandoc's documentation about a command line option
#'
#' @param option One of the supported **long form** command line option. As the
#'   Pandoc MANUAL only concerns the last released Pandoc's version, if the URL
#'   is incorrect this could mean the option has changed.
#'
#' @return Open the webpage at the place regarding the required option
#' @examples
#' \dontshow{withr::local_options(list(rlang_interactive = FALSE))}
#' pandoc_browse_option()
#' pandoc_browse_option("embed-resources")
#' @export
pandoc_browse_option <- function(option = NULL) {
  if (is.null(option)) {
    id <- "#options"
  } else {
    option <- gsub("^--(.*)$", "\\1", option)
    id <- paste0("option--", option)
  }
  pandoc_browse_manual(id)
}

#' Open Pandoc's documentation about citation processing
#'
#' @return Open the webpage at the place regarding citation processing in Pandoc.
#' @examples
#' \dontshow{withr::local_options(list(rlang_interactive = FALSE))}
#' pandoc_browse_citation()
#' @export
pandoc_browse_citation <- function() {
  pandoc_browse_manual("citations")
}

#' Open Pandoc's documentation about exit codes
#'
#' @return Open the webpage at the place regarding exit code thrown by Pandoc.
#' @examples
#' \dontshow{withr::local_options(list(rlang_interactive = FALSE))}
#' pandoc_browse_exit_code()
#' @export
pandoc_browse_exit_code <- function() {
  pandoc_browse_manual("exit-codes")
}
