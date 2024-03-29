% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/glmnet.R
\name{axe-glmnet}
\alias{axe-glmnet}
\alias{axe_call.glmnet}
\title{Axing a glmnet.}
\usage{
\method{axe_call}{glmnet}(x, verbose = FALSE, ...)
}
\arguments{
\item{x}{A model object.}

\item{verbose}{Print information each time an axe method is executed.
Notes how much memory is released and what functions are
disabled. Default is \code{FALSE}.}

\item{...}{Any additional arguments related to axing.}
}
\value{
Axed glmnet object.
}
\description{
glmnet objects are created from the \pkg{glmnet} package, leveraged
to fit generalized linear models via penalized maximum likelihood.
}
\examples{
\dontshow{if (rlang::is_installed("glmnet")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
library(parsnip)

# Wrap a parsnip glmnet model
wrapped_parsnip_glmnet <- function() {
  some_junk_in_environment <- runif(1e6)
  model <- logistic_reg(penalty = 10, mixture = 0.1) \%>\%
    set_engine("glmnet") \%>\%
    fit(as.factor(vs) ~ ., data = mtcars)
  return(model$fit)
}

out <- butcher(wrapped_parsnip_glmnet(), verbose = TRUE)
\dontshow{\}) # examplesIf}
}
