#' @title Reduce the Size of Modeling Objects
#' @name butcher
#' @description Reduce the size of modeling objects after fitting in R so
#' that more memory is available to the user. These parsed-down versions
#' of the original modeling object have been tested to work with their
#' respective predict functions, but future iterations of this package
#' should support additional functions outside of predict. This package
#' provides two s3 generics: axe, which removes the heaviest parts of
#' a model object and reassigns it to a new butcher model object class;
#' and predict, which reassigns it this parsed down version of the model
#' object back to its original class so that it can work with its
#' respective predict function.
#'
#' @importFrom stats lm
#'
#' @importFrom tibble tibble
#'
#' @docType package
NULL



