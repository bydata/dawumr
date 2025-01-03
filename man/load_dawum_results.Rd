% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/load_dawum.R
\name{load_dawum_results}
\alias{load_dawum_results}
\title{Load Result Data from DAWUM}
\usage{
load_dawum_results(newest_only = FALSE, cast = TRUE, verbose = TRUE)
}
\arguments{
\item{newest_only}{Logical. Retrieve only the newest data per institute and
parliament/election.}

\item{cast}{Logical. Cast columns to integers and dates where applicable.
Default: TRUE}

\item{verbose}{Logical. Print message while retrieving data. Default: TRUE}
}
\value{
A data frame with the survey results
}
\description{
This function retrieves data from DAWUM API, extracts relevant data
from the API response and returns a dataframe in which each record represents
the poll result for a party.
}
\examples{
\dontrun{load_dawum_results()}
}
