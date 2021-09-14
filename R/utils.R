resolve_version <- function(version) {
  if (version == "default") return(the$active_version)
  if (version == "latest") return(pandoc_installed_latest())
  version
}

pandoc_feature_requirement <- function(min, version = "default") {
  if (pandoc_version(version = version) < min) {
    rlang::abort(sprintf("This feature is only available for Pandoc `%s` and above.", min))
  }
  invisible(TRUE)
}
