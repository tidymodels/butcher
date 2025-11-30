#' Axing a bagged tree.
#'
#' `*_bagg` objects are created from the \pkg{ipred} package, which
#' is used for bagging classification, regression and survival trees.
#'
#' @inheritParams butcher
#'
#' @return Axed `*_bagg` object.
#'
#' @examplesIf rlang::is_installed(c("ipred", "rpart"))
#' library(ipred)
#'
#' fit_mod <- function() {
#'   boop <- runif(1e6)
#'   bagging(y ~ x, data.frame(y = rnorm(1e4), x = rnorm(1e4)))
#' }
#'
#' mod_fit <- fit_mod()
#' mod_res <- butcher(mod_fit)
#'
#' weigh(mod_fit)
#' weigh(mod_res)
#'
#' @name axe-ipred
#' @aliases axe-regbagg axe-classbagg axe-survbagg
NULL

#' @rdname axe-ipred
#' @export
axe_call.regbagg <- function(x, verbose = FALSE, ...) {
  old <- x

  for (i in seq_along(x$mtrees)) {
    x$mtrees[[i]]$btree <- axe_call(x$mtrees[[i]]$btree)
  }

  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}

#' @rdname axe-ipred
#' @export
axe_call.classbagg <- axe_call.regbagg

#' @rdname axe-ipred
#' @export
axe_call.survbagg <- axe_call.regbagg

#' @rdname axe-ipred
#' @export
axe_ctrl.regbagg <- function(x, verbose = FALSE, ...) {
  old <- x

  for (i in seq_along(x$mtrees)) {
    x$mtrees[[i]]$btree <- axe_ctrl(x$mtrees[[i]]$btree)
  }

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' @rdname axe-ipred
#' @export
axe_ctrl.classbagg <- axe_ctrl.regbagg

#' @rdname axe-ipred
#' @export
axe_ctrl.survbagg <- axe_ctrl.regbagg

#' @rdname axe-ipred
#' @export
axe_data.regbagg <- function(x, verbose = FALSE, ...) {
  old <- x

  for (i in seq_along(x$mtrees)) {
    x$mtrees[[i]]$btree <- axe_data(x$mtrees[[i]]$btree)
  }

  x$y <- numeric(0)
  x$X <- data.frame(NA)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

# note that the class method doesn't wipe the `X` and `y` slots
# as does the regression method. predict.classbagg taps into this data.
#' @rdname axe-ipred
#' @export
axe_data.classbagg <- function(x, verbose = FALSE, ...) {
  old <- x

  for (i in seq_along(x$mtrees)) {
    x$mtrees[[i]]$btree <- axe_data(x$mtrees[[i]]$btree)
  }

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' @rdname axe-ipred
#' @export
axe_data.survbagg <- axe_data.classbagg

#' @rdname axe-ipred
#' @export
axe_env.regbagg <- function(x, verbose = FALSE, ...) {
  old <- x

  for (i in seq_along(x$mtrees)) {
    x$mtrees[[i]]$btree <- axe_env(x$mtrees[[i]]$btree)
  }

  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' @rdname axe-ipred
#' @export
axe_env.classbagg <- axe_env.regbagg

#' @rdname axe-ipred
#' @export
axe_env.survbagg <- axe_env.regbagg
