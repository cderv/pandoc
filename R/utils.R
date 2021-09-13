resolve_version <- function(version) {
  if (version == "default") return(the$active_version)
  if (version == "latest") return(pandoc_installed_latest())
  version
}
