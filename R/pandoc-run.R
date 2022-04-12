#' Run the pandoc binary from R
#'
#' This function is a thin wrapper around the pandoc binary and allow to pass
#' any arguments supported by the Pandoc binary.
#'
#' @param args Character vector, arguments to the pandoc CLI command
#' @inheritParams pandoc_bin
#'
#' @return The output of [processx::run()] invisibly
#' @export
pandoc_run <- function(args, version = "default") {
  bin <- pandoc_bin(version)
  if (is.null(bin)) {
    rlang::abort(sprintf("Requested Pandoc binary is not available: %s", version))
  }
  # Seems like expansion is needed (https://github.com/cderv/pandoc/pull/15)
  # not doing it on windows because `~` does not mean the same for {fs}
  if (pandoc_os() != "windows") bin <- fs::path_expand(bin)
  res <- suppressWarnings(system2(bin, args, stdout = TRUE))
  status <- attr(res, "status", TRUE)
  if (length(status) > 0 && status > 0) {
    rlang::abort(c("Running Pandoc failed with following error", res))
  }
  res
}

#' Get Pandoc version
#'
#' This is equivalent to `pandoc --version`
#'
#' @inheritParams pandoc_run
#' @export
pandoc_version <- function(version = "default") {
  out <- pandoc_run("--version", version = version)
  version <- gsub("^pandoc(?:\\.exe)? ([\\d.]+).*$", "\\1", out[1], perl = TRUE)
  if (grepl("-nightly-", out[1])) version <- paste(version, "9999", sep = ".")
  numeric_version(version)
}

#' Execute any code with a specific Pandoc version
#'
#' This function allows to run any R code by changing the active pandoc version to use
#' without modifying the R session state.
#'
#' This is inspired from **withr** package.
#'
#' @inheritParams pandoc_activate
#' @param code Code to execute with the temporaty active Pandoc version.
#'
#' @return The results of the evaluation of the `code` argument.
#' @export
with_pandoc_version <- function(version, code, rmarkdown = FALSE) {
  old <- pandoc_activate(version, rmarkdown = rmarkdown, quiet = TRUE)
  on.exit(pandoc_activate(old, rmarkdown = rmarkdown, quiet = TRUE))
  force(code)
}

#' @rdname with_pandoc_version
#' @param .local_envir The environment to use for scoping.
#' @export
local_pandoc_version <- function(version, rmarkdown = FALSE,
                                 .local_envir = parent.frame()) {
  rlang::check_installed("withr")
  old <- pandoc_activate(version, rmarkdown = rmarkdown, quiet = TRUE)
  withr::defer(pandoc_activate(old, rmarkdown = rmarkdown, quiet = TRUE), envir = .local_envir)
  invisible(old)
}
