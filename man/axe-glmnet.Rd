% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/glmnet.R
\name{axe-glmnet}
\alias{axe-glmnet}
\alias{axe_call.glmnet}
\title{Axing a glmnet.}
\usage{
\method{axe_call}{glmnet}(x, verbose = TRUE, ...)
}
\arguments{
\item{x}{Model object.}

\item{verbose}{Print information each time an axe method is executed
that notes how much memory is released and what functions are
disabled. Default is \code{TRUE}.}

\item{...}{Any additional arguments related to axing.}
}
\value{
Axed model object.
}
\description{
This is where all the glmnet specific documentation lies.
}
\examples{
library(glmnet)
x <- model.matrix(mpg ~ ., data = mtcars)
y <- as.matrix(sample(c(1, 0), size = 32, replace = TRUE))
fit <- glmnet(x, as.factor(y), family = "binomial")

butcher(fit)
}