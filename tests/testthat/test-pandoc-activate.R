test_that("pandoc_available() works", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  old <- suppressMessages(pandoc_activate("2.11.4", FALSE))
  expect_true(pandoc_available())
  expect_true(pandoc_available(min = "2.7.3"))
  expect_false(pandoc_available(max = "2.7.3"))
  expect_true(pandoc_available(min = "2.7.3", max = "2.14.1"))
  expect_false(pandoc_available(min = "2.7.3", max = "2.10.1"))
  # as if no active version
  the$active_version <- ""
  expect_false(suppressWarnings(pandoc_available()))
  the$active_version <- old
})

test_that("Active version can be changed", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  suppressMessages(pandoc_install("nightly"))
  old <- the$active_version
  expect_message(expect_equal(pandoc_activate("nightly", FALSE), old))
  expect_true(pandoc_is_active("nightly"))
  expect_message(expect_equal(pandoc_activate("latest", FALSE), "nightly"))
  expect_true(pandoc_is_active(pandoc_installed_latest()))
})

test_that("rmarkdown version can be changed", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not_installed("rmarkdown")
  suppressMessages(pandoc_install("2.11.4"))
  suppressMessages(pandoc_install("nightly"))
  old <- the$active_version
  old_rmd <- rmarkdown::find_pandoc()
  expect_equal(pandoc_activate_rmarkdown("2.11.4"), rmarkdown::find_pandoc())
  expect_failure(expect_equal(pandoc_activate_rmarkdown("2.11.4"), old_rmd))
  expect_equal(pandoc_activate_rmarkdown(NULL), old_rmd)
})
