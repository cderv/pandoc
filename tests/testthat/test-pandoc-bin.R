test_that("pandoc_bin() for version installed by this package", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("3.6.3"))
  suppressMessages(pandoc_install("3.1.2"))
  local_pandoc_version("3.1.2")
  expect_match(pandoc_bin(), "3.1.2", fixed = TRUE)
  expect_match(pandoc_bin("3.6.3"), "3.6.3", fixed = TRUE)
})

test_that("pandoc_bin() for external version", {
  skip_on_cran()
  local_mocked_bindings(
    pandoc_bin = function(version) {
      bin <- switch(
        version,
        rstudio = "rstudio/path/pandoc",
        system = "system/path/pandoc",
        quarto = "quarto/bin/tools/pandoc"
      )
      fs::as_fs_path(bin)
    }
  )
  expect_equal(pandoc_bin("rstudio"), fs::fs_path("rstudio/path/pandoc"))
  expect_equal(pandoc_rstudio_bin(), pandoc_bin("rstudio"))
  expect_equal(pandoc_bin("system"), fs::path("system/path/pandoc"))
  expect_equal(pandoc_system_bin(), pandoc_bin("system"))
  expect_equal(pandoc_bin("quarto"), fs::path("quarto/bin/tools/pandoc"))
  expect_equal(pandoc_quarto_bin(), pandoc_bin("quarto"))
})

test_that("pandoc_which_bin() not found", {
  skip_on_cran()
  withr::with_envvar(
    c(RSTUDIO_PANDOC = NA),
    expect_null(pandoc_which_bin("rstudio"))
  )
})

test_that("pandoc_which_bin_quarto() - found with valid pandoc", {
  skip_on_cran()
  local_mocked_bindings(
    sys_which = function(cmd) {
      if (cmd == "quarto") "/usr/bin/quarto" else ""
    },
    sys_system2 = function(command, args, stdout, stderr) {
      if (command == "quarto" && "--paths" %in% args) {
        c("/path/to/quarto/bin", "/path/to/quarto/share")
      } else {
        character(0)
      }
    }
  )
  local_mocked_bindings(
    file_exists = function(path) {
      grepl("tools/pandoc", as.character(path))
    },
    .package = "fs"
  )
  result <- pandoc_which_bin_quarto()
  expect_true(!is.null(result))
  expect_match(as.character(result), "tools/pandoc")
})

test_that("pandoc_which_bin_quarto() - not on PATH", {
  skip_on_cran()
  local_mocked_bindings(
    sys_which = function(cmd) ""
  )
  expect_null(pandoc_which_bin_quarto())
})

test_that("pandoc_which_bin_quarto() - found but pandoc missing", {
  skip_on_cran()
  local_mocked_bindings(
    sys_which = function(cmd) {
      if (cmd == "quarto") "/usr/bin/quarto" else ""
    },
    sys_system2 = function(command, args, stdout, stderr) {
      if (command == "quarto" && "--paths" %in% args) {
        c("/path/to/quarto/bin", "/path/to/quarto/share")
      } else {
        character(0)
      }
    }
  )
  local_mocked_bindings(
    file_exists = function(path) FALSE,
    .package = "fs"
  )
  expect_null(pandoc_which_bin_quarto())
})

test_that("pandoc_which_bin_quarto() - system2 error", {
  skip_on_cran()
  local_mocked_bindings(
    sys_which = function(cmd) {
      if (cmd == "quarto") "/usr/bin/quarto" else ""
    },
    sys_system2 = function(command, args, stdout, stderr) {
      stop("Command failed")
    }
  )
  expect_null(pandoc_which_bin_quarto())
})

test_that("pandoc_citeproc_bin()", {
  skip_on_cran()
  skip_if_offline()
  skip_on_macos_arm()
  suppressMessages(pandoc_install("2.2.1"))
  suppressMessages(pandoc_install("2.7.3"))
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.7.3")
  expect_match(pandoc_citeproc_bin(), "2.7.3", fixed = TRUE)
  expect_match(pandoc_citeproc_bin("2.2.1"), "2.2.1", fixed = TRUE)
  expect_null(pandoc_citeproc_bin("2.11.4"))
})

test_that("pandoc_bin_browse()", {
  expect_null(pandoc_bin_browse())
  withr::with_options(
    c(rlang_interactive = TRUE),
    expect_error(pandoc_bin_browse("0.0.1"))
  )
})
