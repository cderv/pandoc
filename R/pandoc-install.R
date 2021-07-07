
pandoc_install <- function(version = "latest", force = FALSE) {
  if (!rlang::is_installed("gh")) {
    rlang::abort("`gh` package is required to install Pandoc from Gitub")
  }
  if (!rlang::is_installed("gh")) {
    rlang::abort("`gh` package is required to install Pandoc from Gitub")
  }

  # get bundle download url
  release_bundle <- pandoc_release_asset(version)

  # download bundle
  tmp_file <- fs::file_temp(ext = fs::path_ext(release_bundle$url))
  download.file(release_bundle$url, destfile = tmp_file)

  # where to install

  install_dir <- pandoc_home(release_bundle$version)

  if (fs::file_exists(install_dir) && !force) {
    rlang::inform(c(
      sprintf("Pandoc %s already installed.", release_bundle$version),
      "Use 'force = TRUE' to overwrite."))
    return(invisible())
  }

  # install bundle
  switch(fs::path_ext(release_bundle$url),
    gz = utils::untar(tmp_file, exdir = install_dir, tar = "internal"),
    zip  = utils::unzip(tmp_file, exdir = install_dir, junkpaths = TRUE)
  )

  install_dir

}

pandoc_home <- function(version) {
  rappdirs::user_data_dir("r-pandoc", version = version)
}

pandoc_release_asset <- function(version) {
  releases <- pandoc_releases()
  if (version == "latest") {
    i <- 1L
    version <- releases[[1]]$tag_name
  } else {
    versions <- map_chr(releases, "[[", "tag_name")
    i <- which(version == versions)
    if (length(i) == 0) {
      rlang::abort(sprintf("Pandoc version %s can't found.", version))
    }
  }

  # we don't have common zip / tar.gz versions for all OS before
  version_num <- numeric_version(version)
  if (version_num <= numeric_version("2.0.3")) {
    rlang::abort("Only version above 2.0.3 can be installed with this package")
  }

  assets <- releases[[i]][["assets"]]
  names <- map_chr(assets, "[[", "name")

  bundle_name <- pandoc_bundle_name(version)

  i <- which(bundle_name == names)
  if (length(i) == 0L) rlang::abort(sprintf("No release bundle with name '%s' available.", bundle_name))

  bundle_url <- assets[[i]][["browser_download_url"]]

  list(version = version, url = bundle_url)
}

pandoc_bundle_name <- function(version, os = pandoc_os(), arch = pandoc_arch(os)) {
  ext <- switch(os, linux = ".tar.gz", macOS = ,  windows = ".zip")
  arch <- if (!is.null(arch)) paste0("-", arch)
  paste0("pandoc-", version, "-", os, arch, ext)
}

pandoc_releases <- function() {
    rlang::env_cache(pandocenv, "pandoc_releases", fetch_gh_releases())
}

fetch_gh_releases <- function() {
  message("Fetching Pandoc releases info from github...")
  gh::gh(
    "GET /repos/:owner/:repo/releases",
    owner = "jgm",
    repo = "pandoc",
    .limit = Inf,
    .progress = FALSE
  )
}


pandoc_arch <- function(os = c("windows", "macOS", "linux")) {
  os <- rlang::arg_match(os)
  arch <- Sys.info()[["machine"]]
  if (os == "windows") {
    if (arch == "x86-64") return("x86_64")
  } else if (os == "linux") {
    if (arch == "x86_64") return("amd64")
    if (arch %in% c("aarch64", "arm64")) return("arm64")
  } else if (os == "macOS") {
    return()
  }
  rlang::abort("No binary bundle available for this architecture")
}

pandoc_os <- function() {
  os <- tolower(Sys.info()[["sysname"]])
  switch(
    os,
    darwin = "macOS",
    linux = "linux",
    windows = "windows",
    rlang::abort("Unknown operating system.")
  )
}
