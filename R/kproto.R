#' Axing a kproto.
#'
#' @inheritParams butcher
#'
#' @return Axed kproto object.
#'
#' @examples
#' library(clustMixType)
#'
#' ## BEGIN: Generate data
#' # toy data set example from clustMixType::kproto
#' n   <- 100
#' prb <- 0.9
#' muk <- 1.5
#' clusid <- rep(1:4, each = n)
#'
#' x1 <- sample(c("A","B"), 2*n, replace = TRUE, prob = c(prb, 1-prb))
#' x1 <- c(x1, sample(c("A","B"), 2*n, replace = TRUE, prob = c(1-prb, prb)))
#' x1 <- as.factor(x1)
#'
#' x2 <- sample(c("A","B"), 2*n, replace = TRUE, prob = c(prb, 1-prb))
#' x2 <- c(x2, sample(c("A","B"), 2*n, replace = TRUE, prob = c(1-prb, prb)))
#' x2 <- as.factor(x2)
#'
#' x3 <- c(rnorm(n, mean = -muk), rnorm(n, mean = muk), rnorm(n, mean = -muk), rnorm(n, mean = muk))
#' x4 <- c(rnorm(n, mean = -muk), rnorm(n, mean = muk), rnorm(n, mean = -muk), rnorm(n, mean = muk))
#'
#' x <- data.frame(x1,x2,x3,x4)
#' ## END: Generate data
#'
#' kproto_model <- clustMixType::kproto(x = x,
#'                                      k=2,
#'                                      iter.max = 1000,
#'                                      nstart = 10,
#'                                      lambda = clustMixType::lambdaest(x = x,
#'                                                                       num.method = 1,
#'                                                                       fac.method = 1),
#'                                      verbose = FALSE)
#'
#' streamlined_kproto <- butcher(kproto_model, verbose = TRUE)
#'
#' @name axe-kproto
NULL

#' Remove the training data.
#'
#' @rdname axe-kproto
#' @export
axe_data.kproto <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "data", old$data[FALSE,])
  # none of the validation methods in validation_kproto() work if the data is
  # not stored within the model object
  add_butcher_attributes(
    x,
    old,
    disabled = c("validation_kproto()", "summary()"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-kproto
#' @export
axe_fitted.kproto <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "cluster", integer(0))
  x <- exchange(x, "dists", old$dists[FALSE,,drop=FALSE])

  add_butcher_attributes(
    x,
    old,
    disabled = c("clprofiles()", "validation_kproto()"),
    add_class = FALSE,
    verbose = verbose
  )
}
