#' @title save_pkg_deps
#' @description Save status of package dependencies to file
#' @param pkg `character` name of the package
#' @param depsfile `character` file used to save package dapendencies
#' @return NULL
#' @examples
#' \dontrun{
#' if(interactive()){
#'  tmpfile <- tempfile(, fileext = ".RData")
#'  save_pkg_deps("checkdeps", tmpfile)
#'  }
#' }
#' @rdname save_pkg_deps
#' @export
save_pkg_deps <- function(pkg, depsfile) {
    if(!dir.exists(dirname(depsfile))) {
        stop("Invalid name file. Create the output folder beforehand!")
    }
    deps <- check_pkg_deps(pkg)
    save(deps, file = depsfile)
    message("Dependencies status saved to file: ", depsfile)
}
