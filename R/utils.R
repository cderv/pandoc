# @staticimports pkg:staticimports
# read_utf8 write_utf8


resolve_version <- function(version) {
  if (version == "default") {
    return(the$active_version)
  }
  if (version == "latest") {
    return(pandoc_installed_latest())
  }
  version
}

pandoc_feature_requirement <- function(min, version = "default") {
  if (pandoc_version(version = version) < min) {
    rlang::abort(
      sprintf("This feature is only available for Pandoc `%s` and above.", min),
      call = rlang::caller_env()
    )
  }
  invisible(TRUE)
}

# use to activate feature during dev
devmode <- function(devmode = getOption("pandoc.devmode", TRUE)) {
  options(pandoc.devmode = devmode)
}

is_devmode <- function() {
  getOption("pandoc.devmode", FALSE)
}

on_rcmd_check <- function() {
  Sys.getenv("_R_CHECK_PACKAGE_NAME_", "") != ""
}

on_testthat <- function() {
  identical(Sys.getenv("TESTTHAT"), "true")
}

on_ci <- function() {
  isTRUE(as.logical(Sys.getenv("CI")))
}


