test_that("pandoc_list_formats", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("3.6.3"))
  local_pandoc_version("3.6.3")
  expect_snapshot_value(pandoc_list_formats("input"), "json2")
  expect_snapshot_value(pandoc_list_formats("output"), "json2")
})

test_that("pandoc_list_extensions", {
  skip_on_cran()
  skip_if_offline()
  skip_on_macos_arm()
  suppressMessages(pandoc_install("2.7.3"))
  expect_snapshot(error = TRUE, {
    pandoc_list_extensions("markdown", version = "2.7.3")
  })
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.11.4")
  expect_snapshot_value(pandoc_list_extensions("markdown"), "json2")
  expect_snapshot_value(pandoc_list_extensions("gfm"), "json2")
})

test_that("pandoc_list_highlight_style", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("3.6.3"))
  local_pandoc_version("3.6.3")
  expect_snapshot(pandoc_list_highlight_style())
})

test_that("pandoc_list_highlight_languages", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("3.6.3"))
  local_pandoc_version("3.6.3")
  expect_snapshot(pandoc_list_highlight_languages())
})

test_that("pandoc_list_abbreviations", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("3.6.3"))
  local_pandoc_version("3.6.3")
  expect_snapshot(pandoc_list_abbreviations())
})
