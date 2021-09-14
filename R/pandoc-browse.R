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
#' @export
pandoc_browse_release <- function(version = "latest") {
  # Don't offer to install gh here as it is not necessary
  if (rlang::is_installed("gh") &&
      !version %in% c("latest", pandoc_available_versions())) {
    rlang::abort(sprintf("Version '%s' is not a valid pandoc version", version))
  }
  url_view("https://github.com/jgm/pandoc/releases", version)
}

#' Open Pandoc's MANUAL
#'
#' @references <https://pandoc.org/MANUAL.html>
#'
#' @return Open the Pandoc's MANUAL
#' @export
pandoc_browse_manual <- function() {
  # Don't offer to install gh here as it is not necessary
  url_view("https://pandoc.org/MANUAL.html")
}

