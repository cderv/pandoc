.onLoad <- function(libname, pkgname) {
  latest <- pandoc_installed_latest()
  if (!is.null(latest)) pandoc_active_set(latest)
}

