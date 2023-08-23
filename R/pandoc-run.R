#' Run the pandoc binary from R
#'
#' This function is a thin wrapper around the pandoc binary and allow to pass
#' any arguments supported by the Pandoc binary.
#'
#' @param args Character vector, arguments to the pandoc CLI command
#' @inheritParams pandoc_bin
#'
#' @return The output of running `pandoc` binary
#' @examplesIf pandoc::pandoc_available()
#' # Run any command line argument (prefer `pandoc_convert()` for conversion )
#' pandoc::pandoc_run(c("--version"))
#' @examplesIf !is.null(pandoc::pandoc_system_bin()) && pandoc_system_version() > "1.18"
#' pandoc::pandoc_run(c("--list-input-formats"), version = "system")
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
#' This is calling `pandoc --version` to retrieve the version of Pandoc used. A
#' special treatment is done for _nightly_ version as Pandoc project does not
#' use a development version scheme between released versions. This function
#' will add a `.9999` suffix to the version reported by Pandoc.
#'
#' @inheritParams pandoc_run
#'
#' @return The version number for `pandoc` binary as a [base::numeric_version()] object.
#' @examplesIf pandoc::pandoc_available()
#' pandoc::pandoc_version()
#' @examplesIf !is.null(pandoc::pandoc_system_bin()) && pandoc_system_version() > "1.18"
#' pandoc::pandoc_version(version = "system")
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
#' @param code Code to execute with the temporary active Pandoc version.
#'
#' @return The results of the evaluation of the `code` argument.
#' @examplesIf !is.null(pandoc::pandoc_system_bin()) && pandoc_system_version() > "1.18"
#' # Run with pandoc without activating the version for rmarkdown::render()
#' with_pandoc_version("system",
#'   pandoc_bin(),
#'   rmarkdown = FALSE
#' )
#' @examplesIf pandoc::pandoc_is_installed("2.11.4") && rlang::is_installed("rmarkdown")
#' with_pandoc_version("2.11.4", rmarkdown::find_pandoc(), rmarkdown = TRUE)
#' @export
with_pandoc_version <- function(version, code, rmarkdown = getOption("pandoc.activate_rmarkdown", TRUE)) {
  old <- pandoc_activate(version, rmarkdown = rmarkdown, quiet = TRUE)
  on.exit({
    pandoc_activate(old, rmarkdown = rmarkdown, quiet = TRUE)
    if (rmarkdown) reset_rmarkdown_pandoc_version()
  })
  force(code)
}

#' @rdname with_pandoc_version
#' @param .local_envir The environment to use for scoping.
#' @examplesIf rlang::is_interactive() && pandoc::pandoc_is_installed("2.11.4")
#' local({
#'   local_pandoc_version("2.11.4")
#'   pandoc::pandoc_locate()
#'   rmarkdown::find_pandoc()
#' })
#' rmarkdown::find_pandoc()
#' @export
local_pandoc_version <- function(version, rmarkdown = getOption("pandoc.activate_rmarkdown", TRUE),
                                 .local_envir = parent.frame()) {
  rlang::check_installed("withr")

  old <- pandoc_activate(version, rmarkdown = rmarkdown, quiet = TRUE)
  withr::defer(
    {
      pandoc_activate(old, rmarkdown = rmarkdown, quiet = TRUE)
      if (rmarkdown) reset_rmarkdown_pandoc_version()
    },
    envir = .local_envir
  )
  invisible(old)
}
