% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pandoc-activate.R
\name{pandoc_available}
\alias{pandoc_available}
\title{Check if active Pandoc version meet a requirement}
\usage{
pandoc_available(min = NULL, max = NULL)
}
\arguments{
\item{min}{Minimum version expected.}

\item{max}{Maximum version expected}
}
\value{
logical. \code{TRUE} if requirement is met, \code{FALSE} otherwise.
}
\description{
This function allows to test if an active Pandoc version meets a min, max or
in between requirement. See \code{\link[=pandoc_activate]{pandoc_activate()}} about active
version.
}
\details{
If \code{min} and \code{max} are provided, this will check the active version is
in-between two versions. If non is provided (keeping the default \code{NULL} for
both), it will check for an active version and return \code{FALSE} if none is
active.
}
\examples{
# Is there an active version available ?
pandoc_available()
# check for a minimum requirement
pandoc_available(min = "2.11")
# check for a maximum version
pandoc_available(max = "2.18")
# only returns TRUE if Pandoc version is between two bounds
pandoc_available(min = "2.11", max = "2.12")

}
