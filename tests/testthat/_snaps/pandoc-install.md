# Release information are cached

    Code
      x <- pandoc_releases()
    Message
      i Fetching Pandoc releases info from github...

---

    Code
      x <- pandoc_releases()

# Pandoc specific release can be installed and ran

    Code
      expect_null(pandoc_install("2.11.4"))
    Message
      v Pandoc 2.11.4 already installed.
        Use 'force = TRUE' to overwrite.

