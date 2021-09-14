test_that("url_view", {
  expect_snapshot(url_view("https://example.org/"))
})

test_that("pandoc_browse_release()", {
  # trick to cache releases if not yet to avoid message
  suppressMessages(pandoc_releases())
  expect_snapshot(pandoc_browse_release())
  expect_snapshot(pandoc_browse_release("2.7.3"))
  skip_if_not_installed("gh")
  expect_error(pandoc_browse_release("0.1"))
})
