test_that("pandoc_bin() for version installed by this package", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  suppressMessages(pandoc_install("2.7.3"))
  local_pandoc_version("2.7.3")
  expect_match(pandoc_bin(), "2.7.3", fixed = TRUE)
  expect_match(pandoc_bin("2.11.4"), "2.11.4", fixed = TRUE)
})

test_that("pandoc_bin() for external version", {
  skip_on_cran()
  skip_if_not_installed("mockery")
  mocked <- function(version) {
    bin <- switch(version,
                  rstudio = "rstudio/path/pandoc",
                  system = "system/path/pandoc")
    fs::as_fs_path(bin)
  }
  mockery::stub(pandoc_bin, "pandoc_which_bin", mocked)
  mockery::stub(pandoc_rstudio_bin, "pandoc_which_bin", mocked, 2)
  mockery::stub(pandoc_system_bin, "pandoc_which_bin", mocked, 2)
  expect_equal(pandoc_bin("rstudio"), fs::fs_path("rstudio/path/pandoc"))
  expect_equal(pandoc_rstudio_bin(), pandoc_bin("rstudio"))
  expect_equal(pandoc_bin("system"), fs::path("system/path/pandoc"))
  expect_equal(pandoc_system_bin(), pandoc_bin("system"))
})

test_that("pandoc_which_bin() not found", {
  skip_on_cran()
  withr::with_envvar(
    c(RSTUDIO_PANDOC = NA),
    expect_null(pandoc_which_bin("rstudio"))
  )
})

test_that("pandoc_citeproc_bin()", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.2.1"))
  suppressMessages(pandoc_install("2.7.3"))
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.7.3")
  expect_match(pandoc_citeproc_bin(), "2.7.3", fixed = TRUE)
  expect_match(pandoc_citeproc_bin("2.2.1"), "2.2.1", fixed = TRUE)
  expect_null(pandoc_citeproc_bin("2.11.4"))
})

test_that("pandoc_available() works", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  old <- suppressMessages(pandoc_set_version("2.11.4", FALSE))
  expect_true(pandoc_available())
  expect_true(pandoc_available(min = "2.7.3"))
  expect_false(pandoc_available(max = "2.7.3"))
  expect_true(pandoc_available(min = "2.7.3", max = "2.14.1"))
  expect_false(pandoc_available(min = "2.7.3", max = "2.10.1"))
  # as if no active version
  the$active_version <- ""
  expect_false(pandoc_available())
  the$active_version <- old
})

test_that("Active version can be changed", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  suppressMessages(pandoc_install("nightly"))
  old <- the$active_version
  expect_message(expect_equal(pandoc_set_version("nightly", FALSE), old))
  expect_true(pandoc_is_active("nightly"))
  expect_message(expect_equal(pandoc_set_version("latest", FALSE), "nightly"))
  expect_true(pandoc_is_active(pandoc_installed_latest()))
})

