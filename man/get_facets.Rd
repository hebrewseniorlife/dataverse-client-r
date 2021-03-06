% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/native_dv.R
\name{get_facets}
\alias{get_facets}
\title{Get Dataverse facets}
\usage{
get_facets(dataverse, key = Sys.getenv("DATAVERSE_KEY"),
  server = Sys.getenv("DATAVERSE_SERVER"), ...)
}
\arguments{
\item{dataverse}{A character string specifying a Dataverse name or an object of class \dQuote{dataverse}.}

\item{key}{A character string specifying a Dataverse server API key. If one is not specified, functions calling authenticated API endpoints will fail. Keys can be specified atomically or globally using \code{Sys.setenv("DATAVERSE_KEY" = "examplekey")}.}

\item{server}{A character string specifying a Dataverse server. There are multiple Dataverse installations, but the defaults is to use the Harvard Dataverse. This can be modified atomically or globally using \code{Sys.setenv("DATAVERSE_SERVER" = "dataverse.example.com")}.}

\item{...}{Additional arguments passed to an HTTP request function, such as \code{\link[httr]{GET}}, \code{\link[httr]{POST}}, or \code{\link[httr]{DELETE}}.}
}
\value{
A list.
}
\description{
Dataverse metadata facets
}
\details{
Retrieve a list of Dataverse metadata facets.
}
\examples{
\dontrun{
# download file from: 
# https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/ARKOTI
monogan <- get_dataverse("monogan")
(monogan_data <- dataverse_contents(monogan))

# get facets
get_facets(monogan)
}
}
\seealso{
To manage Dataverses: \code{\link{create_dataverse}},  \code{\link{delete_dataverse}}, \code{\link{publish_dataverse}}, \code{\link{dataverse_contents}}; to get datasets: \code{\link{get_dataset}}; to search for Dataverses, datasets, or files: \code{\link{dataverse_search}}
}
