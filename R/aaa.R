# internal environment acting as storage and cache
# Using convention in https://github.com/tidyverse/design/issues/126
the <- rlang::new_environment(
  list(
    # contains the active pandoc version
    active_version = ""

    # other possibles values in this env

    # Information about available pandoc releases fetch on Github API
    # pandoc_releases =
  ),
  parent = emptyenv()
)
