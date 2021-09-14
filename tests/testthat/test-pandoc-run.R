test_that("pandoc_version()", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.11.4")
  expect_equal(pandoc_version(), numeric_version("2.11.4"))
})
