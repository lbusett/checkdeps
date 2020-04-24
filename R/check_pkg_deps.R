#' @title check_pkg_deps
#' @description The function reuturns information about currently installed versions
#'  of dependencies of the package used as input
#' @param pkg `character` name of the package
#' @return `data frame` containing info about version, update date and source of the dependencies
#'  of `pkg` currently installed
#' @examples
#' \dontrun{
#' if(interactive()){
#'  check_pkg_deps("ggplot2")
#'  }
#' }
#' @rdname check_pkg_deps
#' @export
#' @importFrom utils packageDescription
#' @importFrom data.table rbindlist

check_pkg_deps <- function(pkg) {

  # copied from https://github.com/SurajGupta/r-source/blob/master/src/library/tools/R/packages.R
  extract_name <- function(x) {
    ## Assume a character *string*.d
    if(is.na(x)) return(character())
    x <- unlist(strsplit(x, ",[[:space:]]*"))
    x <- sub("[[:space:]]*([[:alnum:].]+).*", "\\1", x)
    x[nzchar(x) & (x != "R")]
  }

  description <- utils::packageDescription(pkg)
  imports <- extract_name(description$Imports)

  info_imports <-  lapply(imports, FUN = function(x) {info <- get_pkginfo(x)})
  info_imports <- data.table::rbindlist(info_imports)
  info_imports <- info_imports[order(-date)]

  if ("Remotes" %in% names(description)) {
    remotes <- unlist(strsplit(description$Remotes, ",[[:space:]]*"))
    remotes <- unlist(lapply(remotes, FUN = function(x) {
      name <- unlist(strsplit(x,"/", fixed = TRUE))[2]
      name <- unlist(strsplit(name,"@", fixed = TRUE))[1]
      name
    }))

    info_remotes <- lapply(remotes, FUN = function(x) get_pkginfo(x))
    info_remotes <- data.table::rbindlist(info_remotes)
    info_remotes <- info_remotes[order(-date)]

    return(as.data.frame(rbind(info_imports, info_remotes), stringsAsFactors = FALSE))
  } else {
    return(as.data.frame(info_imports, stringsAsFactors = FALSE))
  }
}
