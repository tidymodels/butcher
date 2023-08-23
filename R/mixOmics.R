#' Axing mixOmics models
#'
#' `mixo_pls` (via `pls()`), `mixo_spls` (via `spls()`), and `mixo_plsda`
#' (via `plsda()`) objects are created with the mixOmics package,
#' leveraged to fit partial least squares models.
#'
#' The mixOmics package is not available on CRAN, but can be installed
#' from the Bioconductor repository via `remotes::install_bioc("mixOmics")`.
#'
#' @inheritParams butcher
#'
#' @return Axed `mixo_pls`, `mixo_spls`, or `mixo_plsda` object.
#'
#' @examplesIf rlang::is_installed("mixOmics") && !butcher:::is_cran_check()
#' library(butcher)
#' do.call(library, list(package = "mixOmics"))
#'
#' # pls ------------------------------------------------------------------
#' fit_mod <- function() {
#'   boop <- runif(1e6)
#'   pls(matrix(rnorm(2e4), ncol = 2), rnorm(1e4), mode = "classic")
#' }
#'
#' mod_fit <- fit_mod()
#' mod_res <- butcher(mod_fit)
#'
#' weigh(mod_fit)
#' weigh(mod_res)
#'
#' new_data <- matrix(1:2, ncol = 2)
#' colnames(new_data) <- c("X1", "X2")
#' predict(mod_fit, new_data)
#' predict(mod_res, new_data)
#'
#' @name axe-pls
#' @aliases axe-mixo_pls
NULL

#' @rdname axe-pls
#' @export
axe_call.mixo_pls <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' @rdname axe-pls
#' @export
axe_call.mixo_spls <- axe_call.mixo_pls

#' @rdname axe-pls
#' @export
axe_data.mixo_pls <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "input.X", character(0L))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' @rdname axe-pls
#' @export
axe_data.mixo_spls <- axe_data.mixo_pls

#' @rdname axe-pls
#' @export
axe_fitted.mixo_pls <- function(x, verbose = FALSE, ...) {
  old <- x
  x$names <- exchange(x$names, "sample", matrix(NA))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' @rdname axe-pls
#' @export
axe_fitted.mixo_spls <- axe_fitted.mixo_pls
