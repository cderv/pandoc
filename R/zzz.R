.onLoad <- function(libname, pkgname) {
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

  # When testing from R CMD check, don't write into standard config directories
  if (is_rcmd_check()) {
    if (identical(Sys.getenv("R_USER_DATA_DIR"), "")) {
      Sys.setenv(R_USER_DATA_DIR = tempfile())
    }
  }
}
