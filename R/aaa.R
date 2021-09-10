# internal environment acting as storage and cache
# Using convention in https://github.com/tidyverse/design/issues/126
the <- new.env(parent = emptyenv())
