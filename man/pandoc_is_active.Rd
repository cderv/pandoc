% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pandoc-install.R
\name{pandoc_is_active}
\alias{pandoc_is_active}
\title{Is a pandoc version active ?}
\usage{
pandoc_is_active(version)
}
\arguments{
\item{version}{This can be either:
\itemize{
\item \code{"latest"} for the latest release
\item A version number (e.g \code{"2.11.4"}) for a specific version
\item \code{"nightly"} for the last pandoc development built daily
}}
}
\value{
\code{TRUE} is the \code{version} provided is currently the active one (i.e the one used when special \code{"default"} keyword is used).
}
\description{
Is a pandoc version active ?
}
\examples{
# is Pandoc 2.19.2 active ?
pandoc_is_active("2.19.2")
# is it the Pandoc in PATH which is active ?
pandoc_is_active("system")
}
\seealso{
\code{\link[=pandoc_bin]{pandoc_bin()}}
}
