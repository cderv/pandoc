test_that("pandoc_list_formats", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.11.4")
  expect_snapshot_value(pandoc_list_formats("input"), "json2")
  expect_snapshot_value(pandoc_list_formats("output"), "json2")
})

test_that("pandoc_list_extensions", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.7.3"))
  expect_error(pandoc_list_extensions("markdown", bin = pandoc_bin("2.7.3")))
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.11.4")
  expect_snapshot_value(pandoc_list_extensions("markdown"), "json2")
  expect_snapshot_value(pandoc_list_extensions("gfm"), "json2")
})
