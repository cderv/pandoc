#' Activate a specific Pandoc version to be used
#'
#' This function will set the specified version as the default version for the
#' session. By default, the default active version in the most recent one among
#' the installed version (nightly version excluded.)
#'
#' # Special behavior in an interactive session
#'
#' If the `version` to activate is not yet installed, the user will be prompted
#' to choose to install the version.
#'
#' # Default active version
#'
#' When the package is loaded, an active version is set to the first Pandoc
#' binary found between:
#'
#'  * the latest Pandoc version installed with this package (e.g `"2.14.2"`)
#'  * the version shipped with RStudio IDE. (`version = "rstudio"`)
#'  * a version available in PATH (`version = "system"`)
#'
#' @inheritParams pandoc_install
#' @param rmarkdown if `TRUE` (the default) and **rmarkdown** is available, this
#'   will also set the pandoc version as the default one to use with
#'   **rmarkdown** by calling [rmarkdown::find_pandoc()]
#' @param quiet `TRUE` to suppress messages.
#'
#' @return invisibly, the previous active version.
#' @export
pandoc_activate <- function(version = "latest", rmarkdown = TRUE, quiet = FALSE) {
  old_active <- the$active_version
  version <- resolve_version(version)
  if (is.null(version) || version == "") {
    the$active_version <- ""
    version <- NULL
  } else {
    if (!pandoc_is_external_version(version)) {
      # check if a version is installed
      pandoc_is_installed(version, error = TRUE, ask = rlang::is_interactive())
    }
    the$active_version <- version
    if (!quiet) {
      rlang::inform(c(v = sprintf("Version '%s' is now the active one.", the$active_version)))
    }

  }
  if (rmarkdown) pandoc_activate_rmarkdown(version, quiet)
  invisible(old_active)
}

pandoc_activate_rmarkdown <- function(version, quiet = TRUE) {
  if (!rlang::is_installed("rmarkdown")) {
    return(NULL)
  }
  current <- rmarkdown::find_pandoc()
  the$rmarkdown_old_active_version <- current
  new <- rmarkdown::find_pandoc(
    cache = FALSE,
    dir = if (!is.null(version)) fs::path_dir(pandoc_bin(version))
  )
  the$rmarkdown_active_version <- rmarkdown::find_pandoc()
  if (!quiet) {
    rlang::inform(c(i = "Pandoc version also activated for rmarkdown functions."))
  }
  list(
    old = the$rmarkdown_old_active_version,
    new = the$rmarkdown_active_version
  )
}

reset_rmarkdown_pandoc_version <- function() {
  # do nothing if no rmarkdown
  if (!rlang::is_installed("rmarkdown")) {
    return(NULL)
  }

  # old active should be set
  if (!is.null(the$rmarkdown_active_version_old)) {
    rmarkdown::find_pandoc(
      cache = FALSE,
      dir = the$rmarkdown_old_active_version$dir,
      version = the$rmarkdown_old_active_version$version
    )
    return(invisible(TRUE))
  }

  invisible(FALSE)
}

#' Check if active Pandoc version meet a requirement
#'
#' This function allows to test if an active Pandoc version meets a min, max or
#' in between requirement. See [pandoc_activate()] about active
#' version.
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
  active_version <- tryCatch(pandoc_version(version = "default"),
                             error = function(e) NULL
  )
  if (is.null(active_version)) {
    return(FALSE)
  }
  is_above <- is_below <- TRUE
  if (!is.null(min)) is_above <- active_version >= min
  if (!is.null(max)) is_below <- active_version <= max
  return(is_above && is_below)
}

on_load({
  # Set the active version to the first Pandoc binary found between:
  # * "latest" Pandoc version installed with this package
  # * "rstudio" version. Will be always found in the RStudio IDE
  # * "system" version. When one version is available on PATH
  latest_bin <- pandoc_installed_latest()
  rstudio_bin <- pandoc_which_bin("rstudio")
  system_bin <- pandoc_which_bin("system")
  if (!is.null(latest_bin)) {
    the$active_version <- latest_bin
  } else if (!is.null(rstudio_bin)) {
    the$active_version <- "rstudio"
  } else if (!is.null(system_bin)) {
    the$active_version <- "system"
  }
})
