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

# Binary data
iris_bin <- iris[iris$Species != "setosa", ]
iris_bin$Species <- factor(iris_bin$Species)
iris_bin_tbls <- sdf_copy_to(sc, iris_bin, overwrite = TRUE) %>%
  sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)

train <- iris_bin_tbls$train
validation <- iris_bin_tbls$validation

# Boosted tree, note: only supports binary classification
set.seed(1234)
boost_spark <- boost_tree(mode = "classification", trees = 15) %>%
  set_engine("spark") %>%
  fit(Species ~ ., data = train)
ml_save(boost_spark$fit, path = "inst/extdata/boost_spark.rda")

# Parsed data
iris_parsed <- iris[, 1:4]
iris_parsed_tbls <- sdf_copy_to(sc, iris_parsed, overwrite = TRUE)

# Linear reg
reg_spark <- linear_reg() %>%
  set_engine("spark") %>%
  fit(Petal_Width ~ ., data = iris_parsed_tbls)
ml_save(reg_spark$fit, path = "inst/extdata/reg_spark.rda")
