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
