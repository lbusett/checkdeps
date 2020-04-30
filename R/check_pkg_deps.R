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
    if(is.null(x) || is.na(x)) return(character())
    x <- unlist(strsplit(x, ",[[:space:]]*"))
    x <- sub("[[:space:]]*([[:alnum:].]+).*", "\\1", x)
    x[nzchar(x) & (x != "R")]
  }

  description <- utils::packageDescription(pkg)
  out_list <- list()
  index <- 1

  depends <- extract_name(description$Depends)
  if (length(depends != 0)) {
    info_depends <-  lapply(depends, FUN = function(x) {info <- get_pkginfo(x)})
    info_depends <- data.table::rbindlist(info_depends)
    info_depends <- info_depends[order(-date)]
    info_depends$type <- "Depends"
    out_list[[index]] <- info_depends
    index <- index +1
  }

  imports <- extract_name(description$Imports)
  if (length(imports != 0)) {
    info_imports <-  lapply(imports, FUN = function(x) {info <- get_pkginfo(x)})
    info_imports <- data.table::rbindlist(info_imports)
    info_imports <- info_imports[order(-date)]
    info_imports$type <- "Depends"
    out_list[[index]] <- info_imports
    index <- index +1
  }

  if (length(imports != 0)) {
    suggests <- extract_name(description$Suggests)
    info_suggests <-  lapply(imports, FUN = function(x) {info <- get_pkginfo(x)})
    info_suggests <- data.table::rbindlist(info_suggests)
    info_suggests <- info_suggests[order(-date)]
    info_suggests$type <- "Suggests"
    out_list[[index]] <- info_suggests
    index <- index + 1

  }

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
    info_remotes$type <- "Remotes"
    out_list[[index]] <- info_remotes
    index <- index + 1
  }
  if (index > 1) {
    return(as.data.frame(data.table::rbindlist(out_list)))
  }
}
