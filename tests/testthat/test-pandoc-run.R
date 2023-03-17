test_that("pandoc_version()", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.11.4")
  expect_equal(pandoc_version(), numeric_version("2.11.4"))
})

test_that("pandoc_version() deals with nightly version", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install_nightly())
  local_pandoc_version("nightly")
  expect_match(as.character(pandoc_version()), "[.]9999$")
})

test_that("Activating temporarily works", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  suppressMessages(pandoc_install("2.18"))
  local_pandoc_version("2.18", rmarkdown = TRUE)
  with_pandoc_version("2.11.4",
    {
      expect_equal(pandoc_version(), as.numeric_version("2.11.4"))
    },
    rmarkdown = FALSE
  )
  expect_equal(pandoc_version(), as.numeric_version("2.18"))
})

test_that("rmarkdown version is correctly set / reset", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not_installed("rmarkdown")
  suppressMessages(pandoc_install("2.11.4"))
  suppressMessages(pandoc_install("2.18"))
  old_rmd <- rmarkdown::find_pandoc()
  # setting up a default
  local_pandoc_version("2.18", rmarkdown = TRUE)
  expect_equal(rmarkdown::pandoc_version(), as.numeric_version("2.18"))
  # current and previous are saved
  expect_equal(the$rmarkdown_active_version, rmarkdown::find_pandoc())
  expect_equal(the$rmarkdown_old_active_version, old_rmd)
  # changing version temporarily
  before_with <- rmarkdown::find_pandoc()
  withr::local_options(list(pandoc.activate_rmarkdown = TRUE))
  with_pandoc_version("2.11.4", {
    expect_equal(rmarkdown::pandoc_version(), pandoc_version())
    expect_equal(rmarkdown::pandoc_version(), as.numeric_version("2.11.4"))
  })
  expect_equal(rmarkdown::find_pandoc(), before_with)
  expect_equal(pandoc_version(), as.numeric_version("2.18"))
})
