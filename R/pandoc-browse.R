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
#' @param id One of the id available in the HTML page (usually for anchor link).
#'
#' @return Open the Pandoc's MANUAL
#' @export
pandoc_browse_manual <- function(id = NULL) {
  path <- "MANUAL.html"
  if (!is.null(id)) path <- paste0(path, "#", id)
  url_view("https://pandoc.org", path)
}

#' Open Pandoc's documentation about an extension
#'
#' @param extension One of the supported extension. As the Pandoc MANUAL only
#'   concerns the last released Pandoc's version, if the URL is incorrect this
#'   could mean the extensions has changed.
#'
#' @return Open the webpage at the place regarding the required extension.
#' @export
pandoc_browse_extension <- function(extension) {
  id <- paste0("extension-", extension)
  pandoc_browse_manual(id)
}
