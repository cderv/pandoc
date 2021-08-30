#' Retrieve version of Pandoc shipped with RStudio
#'
#' @noRd
pandoc_version_rstudio <- function() {
  pandoc_rstudio_bin <- Sys.getenv("RSTUDIO_PANDOC")
  if (is.na(pandoc_rstudio_bin)) return(NULL)
  pandoc_version(bin = pandoc_bin_impl(pandoc_rstudio_bin))
}
