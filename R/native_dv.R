#' @title Get Dataverse
#' @description Retrieve details of a Dataverse
#' @details This function retrieves a Dataverse from a Dataverse server. To see the contents of the Dataverse, use \code{\link{dataverse_contents}} instead.
#' @template dv 
#' @template envvars
#' @template dots
#' @param check A logical indicating whether to check that the value of \code{dataverse} is actually a numeric
#' @return A list of class \dQuote{dataverse}.
#' @seealso To manage Dataverses: \code{\link{create_dataverse}}, \code{\link{delete_dataverse}}, \code{\link{publish_dataverse}}, \code{\link{dataverse_contents}}; to get datasets: \code{\link{get_dataset}}; to search for Dataverses, datasets, or files: \code{\link{dataverse_search}}
#' @examples
#' \dontrun{
#' # view the root dataverse for a server
#' get_dataverse(":root")
#' dataverse_contents(":root")
#' 
#' # download file from: 
#' # https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/ARKOTI
#' monogan <- get_dataverse("monogan")
#' (monogan_data <- dataverse_contents(monogan))
#'
#' # get a dataset from the dataverse
#' d1 <- get_dataset(monogan_data[[1]])
#' f <- get_file(d1$files$datafile$id[3])
#' }
#' @export
get_dataverse <- function(dataverse, key = Sys.getenv("DATAVERSE_KEY"), server = Sys.getenv("DATAVERSE_SERVER"), check = TRUE, ...) {
    if (isTRUE(check)) {
        dataverse <- dataverse_id(dataverse)
    }
    u <- paste0(api_url(server), "dataverses/", dataverse)
    r <- httr::GET(u, httr::add_headers("X-Dataverse-key" = key), ...)
    httr::stop_for_status(r)
    out <- jsonlite::fromJSON(httr::content(r, as = "text", encoding = "UTF-8"))
    structure(out$data, class = "dataverse")
}

#' @title List contents
#' @description List the contents of a Dataverse
#' @details This function lists the contents of a Dataverse. Contents might include one or more \dQuote{datasets} and/or further Dataverses that themselves contain Dataverses and/or datasets. To view the file contents of a single Dataset, use \code{\link{get_dataset}}.
#' @template dv
#' @template envvars
#' @template dots
#' @return A list of contents of the dataverse, either objects of class \dQuote{dataverse} or \dQuote{dataverse_dataset}.
#' @seealso To manage Dataverses: \code{\link{create_dataverse}}, \code{\link{delete_dataverse}}, \code{\link{publish_dataverse}}; to get datasets: \code{\link{get_dataset}}; to search for Dataverses, datasets, or files: \code{\link{dataverse_search}}
#' @examples
#' \dontrun{
#' # view the root dataverse for a server
#' get_dataverse(":root")
#' dataverse_contents(":root")
#' 
#' # download file from: 
#' # https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/ARKOTI
#' monogan <- get_dataverse("monogan")
#' (monogan_data <- dataverse_contents(monogan))
#'
#' # get a dataset from the dataverse
#' d1 <- get_dataset(monogan_data[[1]])
#' f <- get_file(d1$files$datafile$id[3])
#' }
#' @export
dataverse_contents <- function(dataverse, key = Sys.getenv("DATAVERSE_KEY"), server = Sys.getenv("DATAVERSE_SERVER"), ...) {
    dataverse <- dataverse_id(dataverse)
    u <- paste0(api_url(server), "dataverses/", dataverse, "/contents")
    r <- httr::GET(u, httr::add_headers("X-Dataverse-key" = key), ...)
    httr::stop_for_status(r)
    out <- jsonlite::fromJSON(httr::content(r, as = "text", encoding = "UTF-8"), simplifyDataFrame = FALSE)
    structure(lapply(out$data, function(x) {
        `class<-`(x, if (x$type == "dataset") "dataverse_dataset" else "dataverse")
    }), class = "list")
}

#' @title Get Dataverse facets
#' @description Dataverse metadata facets
#' @details Retrieve a list of Dataverse metadata facets.
#' @template dv
#' @template envvars
#' @template dots
#' @return A list.
#' @seealso To manage Dataverses: \code{\link{create_dataverse}},  \code{\link{delete_dataverse}}, \code{\link{publish_dataverse}}, \code{\link{dataverse_contents}}; to get datasets: \code{\link{get_dataset}}; to search for Dataverses, datasets, or files: \code{\link{dataverse_search}}
#' @examples
#' \dontrun{
#' # download file from: 
#' # https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/ARKOTI
#' monogan <- get_dataverse("monogan")
#' (monogan_data <- dataverse_contents(monogan))
#'
#' # get facets
#' get_facets(monogan)
#' }
#' @export
get_facets <- function(dataverse, key = Sys.getenv("DATAVERSE_KEY"), server = Sys.getenv("DATAVERSE_SERVER"), ...) {
    dataverse <- dataverse_id(dataverse)
    u <- paste0(api_url(server), "dataverses/", dataverse, "/facets")
    r <- httr::GET(u, httr::add_headers("X-Dataverse-key" = key), ...)
    httr::stop_for_status(r)
    jsonlite::fromJSON(httr::content(r, as = "text", encoding = "UTF-8"))$data
}

#' @title Dataverse metadata
#' @description Get metadata for a named Dataverse.
#' @details This function returns a list of metadata for a named Dataverse. Use \code{\link{dataverse_contents}} to list Dataverses and/or datasets contained within a Dataverse or use \code{\link{dataset_metadata}} to get metadata for a specific dataset.
#' @template dv
#' @template envvars
#' @template dots
#' @return A list
#' @seealso \code{\link{set_dataverse_metadata}}
#' @examples
#' \dontrun{
#' # download file from: 
#' # https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/ARKOTI
#' monogan <- get_dataverse("monogan")
#' monogan_data <- dataverse_contents(monogan)
#' dataverse_metadata(monogan)
#' }
#' @export
dataverse_metadata <- function(dataverse, key = Sys.getenv("DATAVERSE_KEY"), server = Sys.getenv("DATAVERSE_SERVER"), ...) {
    dataverse <- dataverse_id(dataverse)
    u <- paste0(api_url(server), "dataverses/", dataverse, "/metadatablocks")
    r <- httr::GET(u, httr::add_headers("X-Dataverse-key" = key), ...)
    httr::stop_for_status(r)
    jsonlite::fromJSON(httr::content(r, as = "text", encoding = "UTF-8"), simplifyDataFrame = FALSE)$data
}
