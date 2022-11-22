#' Axing a KMeansCluster.
#'
#' @inheritParams butcher
#'
#' @return Axed KMeansCluster object.
#'
#' @examplesIf rlang::is_installed("ClusterR")
#' library(ClusterR)
#' data(dietary_survey_IBS)
#' dat <- scale(dietary_survey_IBS[, -ncol(dietary_survey_IBS)])
#' km <- KMeans_rcpp(dat, clusters = 2, num_init = 5)
#' out <- butcher(km, verbose = TRUE)
#'
#' @name axe-KMeansCluster
NULL

#' @rdname axe-KMeansCluster
#' @export
axe_call.KMeansCluster <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    add_class = TRUE,
    verbose = verbose
  )
}

#' @rdname axe-KMeansCluster
#' @export
axe_fitted.KMeansCluster <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "clusters", numeric(0))

  add_butcher_attributes(
    x,
    old,
    add_class = TRUE,
    verbose = verbose
  )
}
