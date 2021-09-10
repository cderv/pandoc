.onLoad <- function(libname, pkgname) {
  latest <- pandoc_installed_latest()
  if (!is.null(latest)) the$active_version <- latest
}

