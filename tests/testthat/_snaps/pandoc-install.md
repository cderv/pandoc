# Release information are cached - fetch Github

    Code
      x <- pandoc_releases()
    Message
      i Fetching Pandoc releases info from github...

---

    Code
      x <- pandoc_releases()

# Release information are cached - cached file

    Code
      x <- pandoc_releases()
    Message
      i Using cached version 'github-cache.rds' in instead of fetching GH

---

    Code
      x <- pandoc_releases()

# Pandoc specific release can be installed and ran

    Code
      expect_null(pandoc_install("3.1.2"))
    Message
      v Pandoc 3.1.2 already installed.
        Use 'force = TRUE' to overwrite.

