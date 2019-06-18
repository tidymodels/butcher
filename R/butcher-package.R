#' @title Reduce the Size of Modeling Objects
#' @name butcher
#' @description After fitting, reduce the size of modeling objects so
#' that more memory is available to the user. These parsed-down versions
#' of the original modeling object have been tested to work with their
#' respective \code{predict} functions. Future iterations of this package
#' should support additional analysis functions outside of just \code{predict}.
#'
#' This package provides six S3 generics:
#' \itemize{
#'   \item \code{\link{axe_call}} To remove the call object.
#'   \item \code{\link{axe_ctrl}} To remove controls associated with training.
#'   \item \code{\link{axe_data}} To remove the original data.
#'   \item \code{\link{axe_env}} To remove inherited environments.
#'   \item \code{\link{axe_fitted}} To remove fitted values.
#'   \item \code{\link{axe_misc}} To remove intermediate values saved during training.
#' }
#'
#' These specific attributes of the model objects are chosen as they are
#' often not required for downstream data analysis functions to work and
#' are often the heaviest components of the model object. By calling
#' the wrapper function \code{axe}, all the sub-axe functions listed above
#' are called on the model object, returning an axed model object that is
#' assigned to a new butcher model object class. This is done since these
#' axed model objects have only been tested to work with its respective
#' \code{predict} function. Each unique butcher model object then has its
#' own \code{predict} method, whose only function is to reassign it back
#' to its original class. Once the axed model object is assigned back to
#' its old class, method dispatch would work and locate the appropriate
#' \code{predict} function. This additional step of butcher class assignment
#' and reassignment is done to allow for error messages to arise when the
#' user attempts to carry out other data analysis functions on the axed
#' model object outside of \code{predict}. This also means that the butcher
#' package \emph{must} be loaded in order for prediction to be done on an
#' axed model object. If future iterations of this package result in
#' axed model objects that work with a greater diversity functions, we
#' may consider removing this additional class assignment step altogether.
#' For the time being, this package is effective in providing much smaller
#' model objects, freeing up a lot of memory on disk.
#'
#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
#' @importFrom stats predict
#' @importFrom glmnet predict
## usethis namespace: end
NULL
