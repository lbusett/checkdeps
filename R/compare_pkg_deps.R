#' @title compare_pkg_deps
#' @description FUNCTION_DESCRIPTION
#' @param pkg PARAM_DESCRIPTION
#' @param depsfile PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname compare_pkg_deps
#' @export
compare_pkg_deps <- function(pkg, depsfile) {

    deps     <- check_pkg_deps(pkg)
    ext_deps <- get(load(depsfile))
    deps$date     <- as.character(deps$date)
    ext_deps$date <- as.character(ext_deps$date)
    message("= ===================================================================== =")
    if (identical(deps, ext_deps)) {
        message("All Dependencies are equal!")
        message("= ===================================================================== =")
    } else {
        for (row in 1:dim(deps)[1]) {
            indata <- deps[row,]
            tmp <- rbind(indata, ext_deps)
            if (any(duplicated(tmp))) {
                # message(indata$Name, ": OK")
            } else {

                message("= Found:    ", paste(indata[1,], collapse = " "))
                message("= Expected: ", paste(ext_deps[which(ext_deps$Name == indata$Name), ], collapse = " "))
                message("= ===================================================================== =")
            }
        }
    }
}
