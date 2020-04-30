#' @title get_pkginfo
#' @description get information about version of an installed package
#' @param pkg `character` name of the package
#' @return `data frame` containing info about update date and source of the repo
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname get_pkginfo
#' @export
#' @importFrom utils packageDescription
#'
get_pkginfo <- function(pkg) {
    description <- suppressWarnings(utils::packageDescription(pkg))
    if (length(description) != 1) {
        # get date
        if ("Date/Publication" %in% names(description)) {
            date <- as.Date(description$"Date/Publication")
        } else {
            if ("Date"  %in% names(description)) {
                date <- as.Date(description$Date)
            } else {
                if ("Built"  %in% names(description)) {
                    date <- as.Date(trimws(strsplit(description$Built, ";")[[1]])[3])
                }
            }
        }

        if ("RemoteUsername" %in% names(description)) {
            username <- description$RemoteUsername
        } else {
            username <- NA
        }

        if ("GithubRef" %in% names(description)) {
            ref <- description$GithubRef
        } else {
            ref <- NA
        }

        if ("GithubSHA1" %in% names(description)) {
            sha <- substring(description$RemoteSha, 1, 7)
        } else {utils::packageDescription(pkg)
            sha = NA
        }

        if (!any(is.na(c(username, ref, sha)))) {
            repo <- paste0(username, "/", pkg, "@", sha)
        } else {
            repo <- description$Repository
            if (is.null(repo)) {
                repo <- "base"
            }
        }

        # return info
        data.frame(Name    = pkg,
                   Version = description$Version,
                   Repo    = ifelse(!is.null(repo), repo, NA),
                   date    = date,
                   stringsAsFactors = FALSE)
    } else {
        data.frame(Name    = pkg,
                   Version = NA,
                   Repo    = NA,
                   date    = NA,
                   stringsAsFactors = FALSE)
    }
}
