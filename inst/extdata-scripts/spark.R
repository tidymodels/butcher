suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))
suppressWarnings(suppressMessages(library(sparklyr)))

# Setup connection --------------------------------------------------------
sc <- spark_connect(master = "local")

iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
  sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)

train <- iris_tbls$train
validation <- iris_tbls$validation

# Traditional approach via sparklyr ---------------------------------------
spark_fit <- ml_logistic_regression(train, Species ~ .)
# Serializes the Spark object into a format to be read by sparklyr
ml_save(spark_fit, path = "inst/extdata/spark.rda")

# New approach via parsnip ------------------------------------------------
# Decision tree
set.seed(1234)
decision_spark <- decision_tree(mode = "classification") %>%
  set_engine("spark") %>%
  fit(Species ~ ., data = train)
# Serializes the Spark object into a format to be read by sparklyr
ml_save(decision_spark$fit, path = "inst/extdata/decision_spark.rda")

