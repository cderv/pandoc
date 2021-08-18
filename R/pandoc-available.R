#' Check if active Pandoc version meet a requirement
#'
#' This function allows to test if an active Pandoc version meets a min, max or
#' in between requirement. This works for Pandoc binaries managed with this
#' package.
#'
#' If `min` and `max` are provided, this will check the active version is
#' in-between two versions. If non is provided (keeping the default `NULL` for
#' both), it will check for an active version and return `FALSE` if none is
#' active.
#'
#' @param min Minimum version expected.
#' @param max Maximum version expected
#' @param strict if `TRUE`, minimum and maximum requirement will be considered
#'   strict.
#'
#' @return logical. `TRUE` if requirement is met, `FALSE` otherwise.
#'
#' @export
pandoc_available <- function(min = NULL, max = NULL, strict = FALSE) {
  # TODO: get the version from calling pandoc instead.
  active_version <- pandoc_active_get()
  # No active pandoc
  if (active_version == "") return(FALSE)

  # compare active with requirement
  active_version <- as.numeric_version(active_version)
  is_above <- is_below <- TRUE
  if (!is.null(min)) {
    greater_than <- if (strict) base::`>` else base::`>=`
    is_above <- greater_than(active_version, min)
  }
  if (!is.null(max)) {
    lower_than <- if (strict) base::`<` else base::`<=`
    is_below <- lower_than(active_version, max)
  }
  return(is_above && is_below)
}
