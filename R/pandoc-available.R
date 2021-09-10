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
#'
#' @return logical. `TRUE` if requirement is met, `FALSE` otherwise.
#'
#' @export
pandoc_available <- function(min = NULL, max = NULL) {
  # TODO: get the version from calling pandoc instead.
  active_version <- the$active_version
  # No active pandoc
  if (active_version == "") return(FALSE)

  # compare active with requirement
  active_version <- as.numeric_version(active_version)
  is_above <- is_below <- TRUE
  if (!is.null(min)) is_above <- active_version >= min
  if (!is.null(max)) is_below <- active_version <= max
  return(is_above && is_below)
}

pandoc_which_bin <- function(which = c("rstudio", "system")) {
  which <- rlang::arg_match(which)
  bin <- switch(which,
                rstudio = Sys.getenv("RSTUDIO_PANDOC"),
                system = Sys.which("pandoc")
  )
  if (!nzchar(bin) || is.na(bin)) return(NULL)
  pandoc_bin_impl(bin)
}

#' Retrieve path and version of Pandoc found on the system PATH
#'
#' Pandoc can also be installed on a system and available through the PATH.
#' Theses function are helper to easily use this specific version.
#'
#' @export
#' @name system_pandoc
pandoc_system_version <- function() {
  pandoc_which_bin("system")
}

#' @rdname system_pandoc
pandoc_system_bin <- function() {
  pandoc_system_bin <- Sys.which("pandoc")
  if (!nzchar(pandoc_system_bin)) return(NULL)
  pandoc_bin_impl(pandoc_system_bin)
}

#' Retrieve path and version of Pandoc shipped with RStudio
#'
#' RStudio IDE ships with a pandoc binary. The PATH is stored in `RSTUDIO_PANDOC`
#' environment variable. Theses function are helper to easily use this specific version.
#'
#' @export
#' @name rstudio_pandoc
pandoc_rstudio_version <- function() {
  path <- pandoc_rstudio_bin()
  if (is.null(path)) return(NULL)
  pandoc_version(bin = path)
}

#' @rdname rstudio_pandoc
pandoc_rstudio_bin <- function() {
  pandoc_which_bin("rstudio")
}
