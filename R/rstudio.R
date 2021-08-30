#' Retrieve path and version of Pandoc shipped with RStudio
#'
#' RStudio IDE ships with a pandoc binary. The PATH is stored in `RSTUDIO_PANDOC`
#' environment variable. Theses function are helper to easily use this specific version.
#'
#' @export
#' @name rstudio_pandoc
pandoc_version_rstudio <- function() {
  path <- pandoc_bin_rstudio()
  if (is.null(path)) return(NULL)
  pandoc_version(bin = path)
}

#' @rdname rstudio_pandoc
pandoc_bin_rstudio <- function() {
  pandoc_rstudio_bin <- Sys.getenv("RSTUDIO_PANDOC")
  if (is.na(pandoc_rstudio_bin)) return(NULL)
  pandoc_bin_impl(pandoc_rstudio_bin)
}
