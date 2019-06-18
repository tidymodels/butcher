#' @title Axe a model object from the class <%= class %>
#'
#' @description Axe accepts a model object and removes any extraneous
#' information contained in that object. Generally, this includes the
#' environments that were carried through from training, the call and
#' any control parameters that were previously utilized to construct
#' the model object, as well as the original data and other miscellaneous
#' parameters that were saved. These parts of the model objects are
#' removed as they are often not used in any post-processing of the
#' model object (i.e., prediction).
#'
#' @param x model object
#' @return axed model object with new butcher class assignment
#' @md
