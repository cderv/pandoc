# if Windows, add .exe extension
pandoc_bin_impl <- function(path, exe = FALSE) {
  if (!nzchar(path) || is.na(path)) return(NULL)
  fs::path(path, "pandoc", ext = ifelse(pandoc_os() == "windows", "exe", ""))
}

#' Get path to the pandoc binary
#'
#' @param version Version to use. Default will be the `"default"` version. Other possible value are
#' * A version number e.g `"2.14.1"`
#' * The nightly version called `"nightly"`
#' * The latest installed version with `"latest"`
#' * Pandoc binary shipped with RStudio IDE with `"rstudio"`
#' * Pandoc binary found in PATH with `"system"`
#'
#' @return Absolute path to the pandoc binary of the requested version.
#' @export
pandoc_bin <- function(version = "default") {
  version <- resolve_version(version)
  if (pandoc_is_external_version(version)) return(pandoc_which_bin(version))

  pandoc_path <- pandoc_locate(version)
  pandoc_bin_impl(pandoc_path)
}

pandoc_which_bin <- function(which = c("rstudio", "system")) {
  which <- rlang::arg_match(which)
  bin <- switch(which,
                rstudio = pandoc_bin_impl(Sys.getenv("RSTUDIO_PANDOC")),
                system = unname(Sys.which("pandoc"))
  )
  fs::as_fs_path(bin)
}

#' Retrieve path and version of Pandoc found on the system PATH
#'
#' Pandoc can also be installed on a system and available through the PATH.
#' Theses function are helper to easily use this specific version.
#'
#' @export
#' @name system_pandoc
pandoc_system_version <- function() {
  path <- pandoc_system_bin()
  if (is.null(path)) return(NULL)
  pandoc_version(bin = path)

}

#' @rdname system_pandoc
pandoc_system_bin <- function() {
  pandoc_bin("system")
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
  pandoc_bin("rstudio")
}

#' Get path to the pandoc-citeproc binary.
#'
#' This function will return the path to `pandoc-citeproc` if available. It will
#' only work with `version` of Pandoc installed by this package.
#'
#' @inheritParams pandoc_locate
#' @return the path to `pandoc-citeproc` binary if it exists. Since Pandoc 2.11,
#'   the citeproc filter has been included into Pandoc itself and is no more
#'   shipped as a binary filter.
#' @export
pandoc_citeproc_bin <- function(version = "default") {
  if (pandoc_is_external_version(version)) {
    rlang::abort("This function does not work with externally installed version of Pandoc.")
  }
  pandoc_path <- pandoc_locate(version)
  path <- fs::path(pandoc_path, "pandoc-citeproc",
                   ext = ifelse(pandoc_os() == "windows", "exe", ""))
  if (!fs::file_exists(path)) return(NULL)
  path
}

#' Activate a specific Pandoc version to be used
#'
#' This function will set the specified version as the default version for the
#' session. By default, the default active version in the most recent one among
#' the installed version (nightly version excluded.)
#'
#' @inheritParams pandoc_install
#' @param rmarkdown if `TRUE` (the default) and **rmarkdown** is available, this
#'   will also set the pandoc version as the default one to use with
#'   **rmarkdown** by calling [rmarkdown::find_pandoc()]
#'
#' @return invisibly, the previous active version.
#' @export
pandoc_set_version <- function(version, rmarkdown = TRUE) {
  old_active <- the$active_version
  version <- resolve_version(version)
  if (is.null(version)) {
    the$active_version <- ""
  } else {
    if (!pandoc_is_external_version(version)) {
      pandoc_is_installed(version, error = TRUE)
    }
    the$active_version <- version
    rlang::inform(c(v = sprintf("Version '%s' is now the active one.", the$active_version)))

    if (rmarkdown && rlang::is_installed("rmarkdown")) {
      bin_dir <- fs::path_dir(pandoc_bin(version))
      rmarkdown::find_pandoc(cache = FALSE, dir = bin_dir)
      rlang::inform(c(i = "This is also true for using with rmarkdown functions."))
    }
  }
  invisible(old_active)
}

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

