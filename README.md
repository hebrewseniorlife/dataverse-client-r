# R Client for Dataverse 4 Repositories #

[![Dataverse Project logo](http://dataverse.org/files/dataverseorg/files/dataverse_project_logo-hp.png "Dataverse Project")](http://dataverse.org)

The **dataverse** package provides access to [Dataverse 4](http://dataverse.org/) APIs, enabling data search, retrieval, and deposit, thus allowing R users to integrate public data sharing into the reproducible research workflow. **dataverse** is the next-generation iteration of [the **dvn** package](http://cran.r-project.org/package=dvn), which works with Dataverse 3 ("Dataverse Network") applications. **dataverse** includes numerous improvements for data search, retrieval, and deposit, including use of the (currently in development) **sword** package for data deposit and the **UNF** package for data fingerprinting.

Some features of the Dataverse 4 API are public and require no authentication. This means in many cases you can search for and retrieve data without a Dataverse account for that a specific Dataverse installation. But, other features require a Dataverse account for the specific server installation of the Dataverse software, and an API key linked to that account. Instructions for obtaining an account and setting up an API key are available in the [Dataverse User Guide](http://guides.dataverse.org/en/latest/user/account.html). (Note: if your key is compromised, it can be regenerated to preserve security.) Once you have an API key, this should be stored as an environment variable called `DATAVERSE_KEY`. It can be set within R using: 

`Sys.setenv("DATAVERSE_KEY" = "examplekey12345")`

Because [there are many Dataverse installations](http://dataverse.org/), all functions in the R client require specifying what server installation you are interacting with. This can be set by default with an environment variable, `DATAVERSE_SERVER`. This should be the Dataverse server, without the "https" prefix or the "/api" URL path, etc. For example, the Harvard Dataverse can be used by setting: 

`Sys.setenv("DATAVERSE_SERVER" = "dataverse.harvard.edu")`

Note: The package attempts to compensate for any malformed values, though.

### Data Discovery ###

Dataverse supplies a pretty robust search API to discover Dataverses, datasets, and files. The simplest searches simply consist of a query string:

```R
dataverse_search("Gary King")
```

More complicated searches might specify metadata fields:

```R
dataverse_search(author = "Gary King", title = "Ecological Inference")
```

And searches can be restricted to specific types of objects (Dataverse, dataset, or file):

```R
dataverse_search(author = "Gary King", type = "dataset")
```

The results are paginated using `per_page` argument. To retrieve subsequent pages, specify `start`.


### Data and Metadata Retrieval ###

The easiest way to access data from Dataverse is to use a persistent identifier (typically a DOI). You can retrieve the contents of a Dataverse dataset:

```R
get_dataset("doi:10.7910/DVN/ARKOTI")
```

retrieve metadata:

```R
dataset_metadata("doi:10.7910/DVN/ARKOTI")
```

and even access files directly in R using the DOI and a filename:

```R
f <- dataverse_file("constructionData.tab", "doi:10.7910/DVN/ARKOTI")

# load it into memory
tmp <- tempfile(fileext = ".dta")
writeBin(f, tmp)
dat <- rio::import(tmp, haven = FALSE)
```

If you don't konw the file name in advance, you can parse the available files returned by `get_dataset()`:

```R
d1 <- get_dataset("doi:10.7910/DVN/ARKOTI")
f <- dataverse_file(d1$files$datafile$id[3])
```

### Data Deposit ###

The data deposit workflow is build on [SWORD v2.0](http://swordapp.org/sword-v2/). This means that to create a new dataset listing, you will have first initialize a dataset entry with some metadata, add one or more files to the dataset, and then publish it. This looks something like the following:

```R
# retrieve your service document
d <- service_document()

# create a list of metadata
metadat <- list(title = "My Study",
                creator = "Doe, John",
                description = "An example study")

# create the dataset
dat <- initiate_dataset("mydataverse", body = metadat)

# add files to dataset
tmp <- tempfile()
write.csv(iris, file = tmp)
f <- add_file(dat, file = tmp)

# publish new dataset
publish_dataset(dat)

# dataset will now be published
list_datasets(dat)
```

Dataverse actually implements two ways to release datasets: the SWORD API and the "native" API. Documentation of the latter is forthcoming.

### Native API Features ###

Coming soon...


## Installation ##

[![CRAN Version](http://www.r-pkg.org/badges/version/dataverse)](http://cran.r-project.org/package=dataverse)
![Downloads](http://cranlogs.r-pkg.org/badges/dataverse)
[![Travis-CI Build Status](https://travis-ci.org/IQSS/dataverse-client-r.png?branch=master)](https://travis-ci.org/IQSS/dataverse-client-r)
[![codecov.io](http://codecov.io/github/IQSS/dataverse-client-r/coverage.svg?branch=master)](http://codecov.io/github/IQSS/dataverse-client-r?branch=master)

You can (eventually) find a stable release on [CRAN](http://cran.r-project.org/web/packages/dataverse/index.html), or install the latest development version from GitHub:

```R
if(!require("ghit")) {
    install.packages("ghit")
}
ghit::install_github("iqss/dataverse-client-r")
library("dataverse")
```

Users interested in downloading metadata from archives other than Dataverse may be interested in Kurt Hornik's [OAIHarvester](http://cran.r-project.org/web/packages/OAIHarvester/index.html) and Scott Chamberlain's [oai](https://cran.fhcrc.org/web/packages/oai/index.html), which offer metadata download from any web repository that is compliant with the [Open Archives Initiative](http://www.openarchives.org/) standards. Additionally, [rdryad](http://cran.fhcrc.org/web/packages/rdryad/index.html) uses OAIHarvester to interface with [Dryad](http://datadryad.org/). The [rfigshare](http://cran.r-project.org/web/packages/rfigshare/) package works in a similar spirit to **dataverse** with [http://figshare.com/](http://figshare.com/).

---

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)

