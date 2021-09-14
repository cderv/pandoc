test_that("pandoc_get_highlight_theme() exports .theme file", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.11.4")
  # default file name
  expect_message(
    theme_file <- pandoc_get_highlight_theme("espresso")
  )
  expect_match(theme_file, "espresso\\.theme$")
  unlink(theme_file)
  tmp_file <- withr::local_tempfile()
  expect_message(
    theme_file <- pandoc_get_highlight_theme(output = tmp_file)
  )
  expect_snapshot_file(theme_file, "default.theme", compare = compare_file_text)
  tmp_file <- withr::local_tempfile(fileext = ".json")
  expect_message(expect_warning(
    theme_file <- pandoc_get_highlight_theme(output = tmp_file)
  ))
  expect_snapshot_file(theme_file, "incorrect-ext.theme", compare = compare_file_text)
  tmp_file <- withr::local_tempfile(fileext = ".theme")
  expect_message(
    theme_file <- pandoc_get_highlight_theme("tango", output = tmp_file)
  )
  expect_snapshot_file(theme_file, "tango.theme", compare = compare_file_text)
})
