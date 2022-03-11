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
  local_edition(2) # required for local_mock()
  mocked <- function(version) {
    bin <- switch(version,
      rstudio = "rstudio/path/pandoc",
      system = "system/path/pandoc"
    )
    fs::as_fs_path(bin)
  }
  local_mock(pandoc_bin = mocked)
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
