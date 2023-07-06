test_that("pandoc_convert()", {
  expect_error(pandoc_convert(file = "a", text = "b", to = "html"))
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install())
  local_pandoc_version("latest")
  expect_s3_class(pandoc_convert(text = "dummy", to = "markdown_strict"), "pandoc_raw_result")
  tmp_file <- withr::local_tempfile()
  expect_warning(
    regexp = NA,
    pandoc_convert(text = c("# Head", "", "content"), to = "markdown_strict", output = tmp_file)
  )
  expect_snapshot_file(tmp_file, "convert-markdown-dummy.md", compare = compare_file_text)
})

test_that("pandoc_convert() handles space in file path", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install())
  local_pandoc_version("latest")
  tmp_dir <- withr::local_tempdir()
  writeLines("# My Markdown", "my test.md")
  expect_no_error(pandoc_convert("my test.md", to = "html"))
  expect_no_error(pandoc_convert("my test.md", to = "html", output = "my test.html"))
})
