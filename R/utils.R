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

is_rcmd_check <- function() {
  Sys.getenv("_R_CHECK_PACKAGE_NAME_", "") != ""
}

# use to activate feature during dev
devmode <- function(devmode = getOption("pandoc.devmode", TRUE)) {
  options(pandoc.devmode = devmode)
}

is_devmode <- function() {
  getOption("pandoc.devmode", FALSE)
}

