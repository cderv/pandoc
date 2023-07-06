test_that("pandoc_export_template() exports templates for a format", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.5"))
  expect_error(pandoc_export_template(version = "2.5"))
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.11.4")
  # default is to print in console
  expect_snapshot(suppressMessages(pandoc_export_template()))
  # other file name
  tmp_file <- withr::local_tempfile()
  expect_message(
    theme_file <- pandoc_export_template("jira", output = tmp_file)
  )
  expect_snapshot_file(theme_file, "default.jira", compare = compare_file_text)
})

test_that("pandoc_export_template() handles space in file path", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install())
  local_pandoc_version("latest")
  withr::local_dir(tempdir())
  expect_no_error(suppressMessages(pandoc_export_template("jira", output = "path with space.jira")))
  expect_true(fs::file_exists("path with space.jira"))
})

test_that("pandoc_export_data_file() exports data file", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.5"))
  expect_error(pandoc_export_data_file("styles.html", version = "2.5"))
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.11.4")
  # default file name
  expect_message(
    theme_file <- pandoc_export_data_file("styles.html")
  )
  expect_match(theme_file, "styles.html")
  expect_snapshot_file(theme_file, "styles.html", compare = compare_file_text)
  unlink(theme_file)
  # other file name
  tmp_file <- withr::local_tempfile(fileext = ".html")
  expect_message(
    theme_file <- pandoc_export_data_file("styles.html", output = tmp_file)
  )
  expect_snapshot_file(theme_file, "styles-custom-path.html", compare = compare_file_text)
})

test_that("pandoc_export_data_file() exports data file", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.5"))
  expect_error(pandoc_export_reference_doc(version = "2.5"))
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.11.4")
  # default file name
  expect_message(
    theme_file <- pandoc_export_reference_doc()
  )
  expect_match(theme_file, "reference.docx")
  unlink(theme_file)
  expect_message(
    theme_file <- pandoc_export_reference_doc("pptx")
  )
  expect_match(theme_file, "reference.pptx")
  unlink(theme_file)
})

test_that("pandoc_export_data_file() handles space in file path", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install())
  local_pandoc_version("latest")
  withr::local_dir(tempdir())
  expect_no_error(suppressMessages(pandoc_export_data_file("styles.html", output = "my styles.html")))
  expect_true(fs::file_exists("my styles.html"))
})

test_that("pandoc_export_highlight_theme() exports .theme file", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.5"))
  expect_error(pandoc_export_highlight_theme(version = "2.5"))
  suppressMessages(pandoc_install("2.11.4"))
  local_pandoc_version("2.11.4")
  # default file name
  expect_message(
    theme_file <- pandoc_export_highlight_theme("espresso")
  )
  expect_match(theme_file, "espresso\\.theme$")
  unlink(theme_file)
  tmp_file <- withr::local_tempfile()
  expect_message(
    theme_file <- pandoc_export_highlight_theme(output = tmp_file)
  )
  expect_snapshot_file(theme_file, "default.theme", compare = compare_file_text)
  tmp_file <- withr::local_tempfile(fileext = ".json")
  expect_message(expect_warning(
    theme_file <- pandoc_export_highlight_theme(output = tmp_file)
  ))
  expect_snapshot_file(theme_file, "incorrect-ext.theme", compare = compare_file_text)
  tmp_file <- withr::local_tempfile(fileext = ".theme")
  expect_message(
    theme_file <- pandoc_export_highlight_theme("tango", output = tmp_file)
  )
  expect_snapshot_file(theme_file, "tango.theme", compare = compare_file_text)
})

test_that("pandoc_export_highlight_theme() handles space in file path", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install())
  local_pandoc_version("latest")
  withr::local_dir(tempdir())
  expect_no_error(suppressMessages(pandoc_export_highlight_theme(output = "my theme.theme")))
  expect_true(fs::file_exists("my theme.theme"))
})
