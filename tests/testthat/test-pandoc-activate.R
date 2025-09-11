test_that("pandoc_available() works", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("3.6.3"))
  old <- suppressMessages(pandoc_activate("3.6.3", FALSE))
  expect_true(pandoc_available())
  expect_true(pandoc_available(min = "3.1.2"))
  expect_false(pandoc_available(max = "3.1.2"))
  expect_true(pandoc_available(min = "3.1.2", max = "3.8.0"))
  expect_false(pandoc_available(min = "3.1.2", max = "3.6.0"))
  # as if no active version
  the$active_version <- ""
  expect_false(suppressWarnings(pandoc_available()))
  the$active_version <- old
})

test_that("Active version can be changed", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("3.6.3"))
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
  suppressMessages(pandoc_install("3.6.3"))
  suppressMessages(pandoc_install("nightly"))
  old <- the$active_version
  old_rmd <- rmarkdown::find_pandoc()
  expect_equal(
    pandoc_activate_rmarkdown("3.6.3"),
    list(old = old_rmd, new = rmarkdown::find_pandoc())
  )
  expect_equal(pandoc_activate_rmarkdown(NULL)$new, old_rmd)
})
