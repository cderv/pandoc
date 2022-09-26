# if Windows, add .exe extension
pandoc_bin_impl <- function(path, exe = FALSE) {
  if (!nzchar(path) || is.na(path) || is.null(path)) {
    return(NULL)
  }
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
#' @examples
#' pandoc_bin()
#' pandoc_bin("2.18")
#' pandoc_bin("nightly")
#' pandoc_bin("rstudio")
#' pandoc_bin("system")
#' @export
pandoc_bin <- function(version = "default") {
  version <- resolve_version(version)
  if (pandoc_is_external_version(version)) {
    return(pandoc_which_bin(version))
  }

  pandoc_path <- pandoc_locate(version)
  pandoc_bin_impl(pandoc_path)
}

pandoc_which_bin <- function(which = c("rstudio", "system")) {
  which <- rlang::arg_match(which)
  bin <- switch(which,
    rstudio = pandoc_bin_impl(Sys.getenv("RSTUDIO_PANDOC")),
    system = unname(Sys.which("pandoc"))
  )
  if (!nzchar(bin) || is.na(bin) || is.null(bin)) {
    return(NULL)
  }
  fs::as_fs_path(bin)
}


#' @details `pandoc_bin_browse()` allows to open in OS explorer the folder where
#'   `pandoc_bin()` is at, when in interactive mode only.
#'
#' @examples
#' pandoc_bin_browse("2.18")
#' @rdname pandoc_bin
pandoc_bin_browse <- function(version = "default") {
  if (!rlang::is_interactive()) {
    return(NULL)
  }
  bin <- pandoc_bin(version)
  if (is.null(bin)) rlang::abort(paste0("Version ", version, " does not seem to be installed."))
  bin_dir <- fs::path_dir(bin)
  if (pandoc_os() == "windows") {
    try(shell.exec(bin_dir))
  } else if (pandoc_os() == "macOS") {
    system(paste("open ", shQuote(bin_dir)))
  } else {
    system(paste("xdg-open ", shQuote(bin_dir)))
  }
  return(invisible(TRUE))
}

#' Retrieve path and version of Pandoc found on the system PATH
#'
#' Pandoc can also be installed on a system and available through the PATH.
#' Theses function are helper to easily use this specific version.
#'
#'
#' @return `pandoc_system_version()` returns the version number for `pandoc` binary found in PATH as a [base::numeric_version()] object.
#'
#'
#' @seealso [pandoc_version()], [pandoc_bin()]
#' @name system_pandoc
#' @examplesIf !is.null(pandoc::pandoc_system_bin())
#' @export
pandoc_system_version <- function() {
  pandoc_version(version = "system")
}

#' @rdname system_pandoc
#' @return `pandoc_system_bin()` returns absolute path to the `pandoc` binary found in PATH.
#' @examples
#' pandoc_system_bin()
#' @export
pandoc_system_bin <- function() {
  pandoc_bin(version = "system")
}

#' Retrieve path and version of Pandoc shipped with RStudio
#'
#' RStudio IDE ships with a pandoc binary. The path is stored in `RSTUDIO_PANDOC`
#' environment variable. Theses function are helper to easily use this specific version.
#'
#' @return `pandoc_rstudio_version()` returns the version number for `pandoc` binary used by RStudio IDE as a [base::numeric_version()] object.
#'
#' @seealso [pandoc_version()], [pandoc_bin()]
#' @examplesIf !is.null(pandoc::pandoc_rstudio_bin())
#' @export
#' @name rstudio_pandoc
pandoc_rstudio_version <- function() {
  pandoc_version(version = "rstudio")
}

#' @rdname rstudio_pandoc
#' @return `pandoc_system_bin()` returns absolute path to the `pandoc` binary used by RStudio IDE.
#' @examples
#' pandoc_rstudio_bin()
#' @export
pandoc_rstudio_bin <- function() {
  pandoc_bin(version = "rstudio")
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
#' @examplesIf rlang::is_interactive()
#' # Look into current active version
#' pandoc_citeproc_bin()
#' @examplesIf pandoc::pandoc_is_installed("2.9.2")
#' # Look into a specific version
#' pandoc_citeproc_bin("2.9.2")
#' @export
pandoc_citeproc_bin <- function(version = "default") {
  if (pandoc_is_external_version(version)) {
    rlang::abort("This function does not work with externally installed version of Pandoc.")
  }
  pandoc_path <- pandoc_locate(version)
  path <- fs::path(pandoc_path, "pandoc-citeproc",
    ext = ifelse(pandoc_os() == "windows", "exe", "")
  )
  if (!fs::file_exists(path)) {
    return(NULL)
  }
  path
}
