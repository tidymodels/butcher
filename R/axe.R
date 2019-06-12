#' #' Axe an object.
#' #'
#' #' Reduce the size of a model object so that it takes up less memory on disk.
#' #' Currently the model object is stripped down to the point that only the
#' #' minimal components necessary for the `predict` function to work remain.
#' #' Future adjustments to this function will be needed to avoid removal of
#' #' model fit components to ensure it works with other downstream functions.
#' #'
#' #' @param x model object
#' #'
#' #' @return axed model object
#' #' @export
#' #' @examples
#' #'
#' #' axe(lm_fit)
#' axe <- function(x, ...) {
#'   UseMethod("axe")
#' }
#'
#' # axe.default <- function(x, ...) {
#' #
#' # }
#'
#' #' @export
#' axe.lm <- function(x, ...) {
#'   stopifnot(inherits(x, "lm"))
#'   keep_parts <- c("xlevels",
#'                   "weights",
#'                   "na.action",
#'                   "offset",
#'                   "residuals",
#'                   "df.residual",
#'                   "contrasts",
#'                   "coefficients",
#'                   "rank",
#'                   "qr",
#'                   "terms",
#'                   "model")
#'   # Check these parts exist
#'   inventory <- take_inventory(x)
#'   # Remove undesired inventory
#'   undesired_inventory <- inventory$overall[!inventory$overall %in% keep_parts]
#'   x[undesired_inventory] <- NULL
#'   # Remove undesired environment
#'   x_axed <- remove_env(x, inventory$all_attributes)
#'   # Remove response, not compatible is user provides no new data in `predict`
#'   # x_axed <- remove_response(x_axed)
#'   return(x_axed)
#' }
#'
#' axe.elnet <- function(x, ...) {
#'   stopifnot(inherits(x, "elnet"))
#'   keep_parts <- c("a0",
#'                   "beta",
#'                   "lambda",
#'                   "offset",
#'                   "df",
#'                   "dev.ratio",
#'                   "call") # may want to include df, dev for display?
#'   # Check these parts exist
#'   inventory <- take_inventory(x)
#'   # Remove undesired inventory
#'   undesired_inventory <- inventory$overall[!inventory$overall %in% keep_parts]
#'   x[undesired_inventory] <- NULL
#'   return(x)
#' }
#'
#' #' @export
#' axe.model_fit <- function(x, ...) {
#'   if(!inherits(x, "model_fit")){
#'     stop("Not a parsnip model object.")
#'   }
#'   axe(x$fit, ...)
#' }
#'
#'
#'
