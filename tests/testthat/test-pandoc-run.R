test_that("pandoc_get_version", {
  suppressMessages(pandoc_install("2.11.4"))
  with_pandoc_version("2.11.4", {
    expect_equal(pandoc_get_version(), numeric_version("2.11.4"))
  })
})


