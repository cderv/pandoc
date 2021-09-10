#' Get path to the pandoc binary
#'
#' @param version Version to use. Default will be the `"default"` version. Other possible value are
#' * A version number e.g `"2.14.1"`
#' * The nightly version e.g `"nightly"`
#' * The latest installed version `"latest"`
#'
#' @return Absolute path to the pandoc binary of the requested version.
#' @export
pandoc_bin <- function(version = "default") {
  pandoc_path <- pandoc_locate(version)
  pandoc_bin_impl(pandoc_path)
}

# if Windows, add .exe extension
pandoc_bin_impl <- function(path, exe = FALSE) {
  fs::path(path, "pandoc", ext = ifelse(pandoc_os() == "windows", "exe", ""))
}

#' @rdname pandoc_bin
#' @return For `pandoc_citeproc_bin()`, it returns the path to `pandoc-citeproc` binary
#'   if it exists. Since Pandoc 2.11, the citeproc filter has been included into
#'   Pandoc itself and is no more shipped as a binary filter.
pandoc_citeproc_bin <- function(version = "default") {
  pandoc_path <- pandoc_locate(version)
  path <- fs::path(pandoc_path, "pandoc-citeproc",
           ext = ifelse(pandoc_os() == "windows", "exe", ""))
  if (!fs::file_exists(path)) return(NULL)
  path
}

#' Run the pandoc binary from R
#'
#' This function is a thin wrapper around the pandoc binary and allow to pass
#' any arguments supported by the Pandoc binary.
#'
#' @param args Character vector, arguments to the pandoc CLI command
#' @param bin Path to a pandoc binary. Default to the active version.
#' @param echo Whether to print the standard output and error to the screen.
#'
#' @return The output of [processx::run()] invisibly
#' @export
pandoc_run <- function(args, bin = pandoc_bin(), echo = TRUE) {
  invisible(processx::run(bin, args, echo = echo))
}

pandoc_run_to_file <- function(..., echo = FALSE) {
  res <- pandoc_run(..., echo = echo)
  tmp_file <- tempfile()
  on.exit(unlink(tmp_file))
  brio::write_file(res$stdout, tmp_file)
  brio::read_lines(tmp_file)
}

#' Get Pandoc version
#'
#' This is equivalent to `pandoc --version`
#'
#' @inheritParams pandoc_run
#' @export
pandoc_version <- function(bin = pandoc_bin()) {
  out <- pandoc_run("--version", bin = bin, echo = FALSE)[["stdout"]]
  version <- strsplit(out, "\n")[[1]][1]
  version <- gsub("^pandoc(?:\\.exe)? ([\\d.]+).*$", "\\1", version, perl = TRUE)
  numeric_version(version)
}

#' Execute any code with a specific Pandoc version
#'
#' This function allows to run any R code by changing the active pandoc version to use
#' without modifying the R session state.
#'
#' This is inspired from **withr** package.
#'
#' @inheritParams pandoc_set_version
#' @param code Code to execute with the temporaty active Pandoc version.
#'
#' @return The results of the evaluation of the `code` argument.
#' @export
with_pandoc_version <- function(version, code, rmarkdown = FALSE) {
  old <- pandoc_set_version(version, rmarkdown = rmarkdown)
  on.exit(the$active_version <- old)
  force(code)
}

local_pandoc_version <- function(version, rmarkdown = FALSE,
                                 .local_envir = parent.frame()) {
  rlang::check_installed("withr")
  old <- suppressMessages(pandoc_set_version(version, rmarkdown = rmarkdown))
  withr::defer(the$active_version <- old, envir = .local_envir)
  invisible(old)
}
