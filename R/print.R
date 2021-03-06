# dataverse class
print.dataverse <- function(x, ...) {
    if ("id" %in% names(x)) {
        cat("Dataverse (", x$id, "): ", x$alias, "\n", sep = "")
        cat("Name:        ", x$name, "\n", sep = "")
    } else {
        cat("Dataverse: ", x$alias, "\n", sep = "")
        cat("Name:      ", x$name, "\n", sep = "")
    }
    if ("description" %in% names(x)) {
        cat("Description: ", x$description, "\n", sep = "")
    }
    if ("creationDate" %in% names(x)) {
        cat("Created:     ", x$creationDate, "\n", sep = "")
    }
    if ("creator" %in% names(x)) {
        cat("Creator:     ", x$creator$identifier, "\n", sep = "")
    }
    if (("terms_apply" %in% names(x)) && (x$terms_apply == "true")) {
        cat("Terms of Use:   ", x$terms_of_use, "\n", sep = "")
    }
    invisible(x)
}

# dataverse_dataset class
print.dataverse_dataset <- function(x, ...) {
    cat("Dataset (", x$id, "): ", x$persistentUrl, "\n", sep = "")
    if ("latestVersion" %in% names(x)) {
        print(x$latestVersion)
    } else {
        cat("Version (", x$id, ")", sep = "")
        if ("versionNumber" %in% names(x)) {
            cat(": ", x$versionNumber, ".", x$versionMinorNumber, ", ", x$versionState, "\n", sep = "")
        } else {
            cat("\n")
        }
        if ("releaseTime" %in% names(x)) {
            cat("Release Date: ", x$releaseTime, "\n", sep = "")
        }
        if ("files" %in% names(x)) {
            n <- length(x$files)
            cat(n, ngettext(n, " File:", " Files:"), "\n", sep = "")
            print(x$files)
        }
    }
    invisible(x)    
}

# dataverse_dataset_version class
print.dataverse_dataset_version <- function(x, ...) {
    cat("Version (", x$id, "): ", x$versionNumber, ".", x$versionMinorNumber, ", ", x$versionState, "\n", sep = "")
    cat("Release Date: ", x$releaseTime, "\n", sep = "")
    n <- length(x$files)
    cat(n, ngettext(n, " File:", " Files:"), "\n", sep = "")
    print(x$files)
    invisible(x)    
}

# get_file class
print.get_file <- function(x, ...) {
    cat("File (", x$datafile$id, "): ", x$datafile$filename, "\n", sep = "")
    cat("Dataset version: ", x$datasetVersionId, "\n", sep = "")
    if ("md5" %in% names(x$datafile)) {
        cat("MD5: ", x$datafile$md5, "\n", sep = "")
    }
    cat("Description: ", x$datafile$description, "\n", sep = "")
    invisible(x)
}

# get_file class
print.dataverse_file <- function(x, ...) {
    cat("File (", x$dataFile$id, "): ", x$dataFile$filename, "\n", sep = "")
    cat("Dataset version: ", x$datasetVersionId, "\n", sep = "")
    if ("md5" %in% names(x$dataFile)) {
        cat("MD5: ", x$dataFile$md5, "\n", sep = "")
    }
    cat("Description: ", x$dataFile$description, "\n", sep = "")
    invisible(x)
}

# dataverse_group class
print.dataverse_group <- function(x, ...) {
    cat("Group:      ", x$displayName, "\n", sep = "")
    cat("Alias:      ", x$groupAliasInOwner, "\n", sep = "")
    cat("Owner:      ", x$owner, "\n", sep = "")
    cat("Dataverse:  ", x$dataverse, "\n", sep = "")
    cat("Identifier: ", x$identifier, "\n", sep = "")
    cat("Assignees:  ", length(x$containedRoleAssignees), "\n\n", sep = "")
    invisible(x)
}

# dataverse_role class

# dataverse_role_assignment class
print.dataverse_role_assignment <- function(x, ...) {
    cat("ID:        ", x$id, "\n", sep = "")
    cat("Assignee:  ", x$assignee, "\n", sep = "")
    cat("Role (", x$roleId, "):  ", x[["_roleAlias"]], "\n", sep = "")
    cat("Dataverse: ", x$dataverse, "\n", sep = "")
    invisible(x)
}
