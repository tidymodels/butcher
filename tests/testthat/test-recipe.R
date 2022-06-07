skip_if_not_installed("recipes")
skip_if_not_installed("rsample")

# Load libraries
suppressPackageStartupMessages(library(recipes))
suppressPackageStartupMessages(library(rsample))
suppressPackageStartupMessages(library(modeldata))

# Data sets used for testing
data(biomass)
biomass_tr <- biomass[biomass$dataset == "Training",]
biomass_te <- biomass[biomass$dataset == "Testing",]
data(credit_data)
set.seed(55)
train_test_split <- initial_split(credit_data)
credit_tr <- training(train_test_split)

# Additional data sets used
data(covers)
data(Sacramento)

# Test helpers
terms_empty_env <- function(axed, step_number) {
  expect_identical(attr(axed$steps[[step_number]]$terms[[1]], ".Environment"),
                   rlang::base_env())
}

impute_empty_env <- function(axed, step_number) {
  expect_identical(attr(axed$steps[[step_number]]$impute_with[[1]], ".Environment"),
                   rlang::base_env())
}

inputs_empty_env <- function(axed, input_number) {
  expect_identical(attr(axed$steps[[1]]$input[[input_number]], ".Environment"),
                   rlang::base_env())
}

test_en <- rlang::base_env()

test_that("recipe + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_center(all_predictors()) %>%
    step_scale(all_predictors()) %>%
    step_spatialsign(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
  terms_empty_env(x, 2)
  terms_empty_env(x, 3)
})

test_that("recipe + step_knnimpute + axe_env() works", {
  skip_if_recipes_post_0.1.16()

  rec <- recipe(credit_tr) %>%
    step_knnimpute(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
  impute_empty_env(x, 1)
})
test_that("recipe + step_impute_knn + axe_env() works", {
  skip_if_recipes_pre_0.1.16()

  rec <- recipe(credit_tr) %>%
    step_impute_knn(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
  impute_empty_env(x, 1)
})

test_that("recipe + step_lowerimpute + axe_env() works", {
  skip_if_recipes_post_0.1.16()

  rec <- recipe(credit_tr) %>%
    step_lowerimpute(Time, Expenses, threshold = c(40,40))
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})
test_that("recipe + step_impute_lower + axe_env() works", {
  skip_if_recipes_pre_0.1.16()

  rec <- recipe(credit_tr) %>%
    step_impute_lower(Time, Expenses, threshold = c(40,40))
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_rollimpute + axe_env() works", {
  skip_if_recipes_post_0.1.16()

  rec <- recipe(credit_tr) %>%
    step_rollimpute(Time, statistic = median, window = 3)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})
test_that("recipe + step_impute_roll + axe_env() works", {
  skip_if_recipes_pre_0.1.16()

  rec <- recipe(credit_tr) %>%
    step_impute_roll(Time, statistic = median, window = 3)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_BoxCox + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_BoxCox(rec, all_numeric())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_bs + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_bs(carbon, hydrogen)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_hyperbolic + axe_env() works", {
  skip_if_recipes_pre_0.2.1()
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_hyperbolic(Income, func = "cosh", inverse = FALSE)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_inverse + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_inverse(Income)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_invlogit + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_center(carbon, hydrogen) %>%
    step_scale(carbon, hydrogen) %>%
    step_invlogit(carbon, hydrogen)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
  terms_empty_env(x, 2)
  terms_empty_env(x, 3)
})

test_that("recipe + step_log + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_log(Income)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_logit + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_logit(Income)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_mutate + axe_env() works", {
  rec <- recipe( ~ ., data = iris) %>%
    step_mutate(
      dbl_width = Sepal.Width * 2,
      half_length = Sepal.Length / 2
    )
  x <- axe_env(rec)
  inputs_empty_env(x, 1)
  inputs_empty_env(x, 2)
})

test_that("recipe + step_ns + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_ns(carbon, hydrogen)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_poly + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_poly(carbon, hydrogen)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_relu + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_relu(carbon, shift = 40)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_sqrt + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_sqrt(all_numeric())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_YeoJohnson + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_YeoJohnson(all_numeric())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_discretize + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_discretize(Income)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_bin2factor + axe_env() works", {
  rec <- recipe(~ description, covers) %>%
    step_regex(description, pattern = "(rock|stony)", result = "rocks") %>%
    step_regex(description, pattern = "(rock|stony)", result = "more_rocks") %>%
    step_bin2factor(rocks)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
  terms_empty_env(x, 2)
  terms_empty_env(x, 3)
})

test_that("recipe + step_count + axe_env() works", {
  rec <- recipe(~ description, covers) %>%
    step_count(description, pattern = "(rock|stony)", result = "rocks")
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_date + axe_env() works", {
  examples <- data.frame(Dan = as.Date("2002-03-04") + 1:10,
                         Stefan = as.Date("2006-01-13") + 1:10)
  rec <- recipe(~ Dan + Stefan, examples) %>%
    step_date(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_dummy + axe_env() works", {
  rec <- recipe(~ city + sqft + price, data = Sacramento) %>%
    step_dummy(city)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_string2factor + axe_env() works", {
  rec <- recipe(~ city + sqft + price, data = Sacramento) %>%
    step_factor2string(city) %>%
    step_string2factor(city)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
  terms_empty_env(x, 2)
})

test_that("recipe + step_factor2string + axe_env() works", {
  rec <- recipe(~ city + sqft + price, data = Sacramento) %>%
    step_factor2string(city)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_holiday + axe_env() works", {
  examples <- data.frame(someday = Sys.Date() + 1:40)
  rec <- recipe(~ someday, examples) %>%
    step_holiday(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_integer + axe_env() works", {
  rec <- Sacramento %>%
    dplyr::select(type, sqft, price, beds) %>%
    recipe(type ~ .) %>%
    step_integer(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_novel + axe_env() works", {
  sacr_tr <- Sacramento[1:500,] %>% dplyr::mutate(city = as.character(city))
  sacr_te <- Sacramento[501:nrow(Sacramento),] %>% dplyr::mutate(city = as.character(city))
  sacr_te$city[3] <- "boopville"
  sacr_te$city[4] <- "beeptown"
  rec <- recipe(type ~ ., data = sacr_tr) %>%
    step_novel(city, zip)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_num2factor + axe_env() works", {
  iris2 <- iris
  iris2$Species <- as.numeric(iris2$Species)
  rec <- recipe(~ ., data = iris2) %>%
    step_num2factor(
      Species,
      levels = c("setosa", "versicolor", "virginica")
    )
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_ordinalscore + axe_env() works", {
  fail_lvls <- c("meh", "annoying", "really_bad")
  ord_data <-
    data.frame(item = c("paperclip", "twitter", "airbag"),
               fail_severity = factor(fail_lvls,
                                      levels = fail_lvls,
                                      ordered = TRUE))
  rec <- recipe(~ item + fail_severity, data = ord_data) %>%
    step_dummy(item) %>%
    step_ordinalscore(fail_severity)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
  terms_empty_env(x, 2)
})

test_that("recipe + step_other + axe_env() works", {
  rec <- recipe(~ city + zip, data = Sacramento) %>%
    step_other(city, zip, threshold = .1, other = "other values")
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_unorder + axe_env() works", {
  lmh <- c("Low", "Med", "High")
  examples <- data.frame(X1 = factor(rep(letters[1:4], each = 3)),
                         X2 = ordered(rep(lmh, each = 4),
                                      levels = lmh))
  rec <- recipe(~ X1 + X2, data = examples) %>%
    step_unorder(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_interact + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_interact(terms = ~ carbon:hydrogen)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms, ".Environment"), test_en)
})

test_that("recipe + step_range + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_range(carbon, hydrogen)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_geodist + axe_env() works", {
  data(Smithsonian)
  rec <- recipe( ~ ., data = Smithsonian) %>%
    step_geodist(lat = latitude, lon = longitude, log = FALSE,
                 ref_lat = 38.8986312, ref_lon = -77.0062457)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$lon[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[1]]$lat[[1]], ".Environment"), test_en)
})

test_that("recipe + step_ratio + axe_env() works", {
  data(biomass)
  biomass$total <- apply(biomass[, 3:7], 1, sum)
  biomass_tr <- biomass[biomass$dataset == "Training",]
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur + total,
                data = biomass_tr) %>%
    step_ratio(all_predictors(), denom = denom_vars(total))
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[1]]$denom[[1]], ".Environment"), test_en)
})

test_that("recipe + step_arrange + axe_env() works", {
  sort_vars <- c("Sepal.Length", "Petal.Length")
  rec <- recipe( ~ ., data = iris) %>%
    step_arrange(!!!syms(sort_vars))
  x <- axe_env(rec)
  inputs_empty_env(x, 1)
  inputs_empty_env(x, 2)
})

test_that("recipe + step_filter + axe_env() works", {
  rec <- recipe( ~ ., data = iris) %>%
    step_filter(Sepal.Length > 4.5, Species == "setosa")
  x <- axe_env(rec)
  inputs_empty_env(x, 1)
  inputs_empty_env(x, 2)
})

test_that("recipe + step_slice + axe_env() works", {
  rec <- recipe( ~ ., data = iris) %>%
    step_slice(1:3)
  x <- axe_env(rec)
  inputs_empty_env(x, 1)
})

test_that("recipe + step_zv + axe_env() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_zv(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_window + axe_env() works", {
  rec <- recipe(Species ~ ., data = iris) %>%
    step_window(starts_with("Sepal"),
                size = 3,
                statistic = "median",
                names = paste0("med_3pt_", 1:2),
                role = "outcome")
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_unorder + axe_env() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_unorder(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_spatialsign + axe_env() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_spatialsign(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_shuffle + axe_env() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_shuffle(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_rm + axe_env() works", {
  rec <- recipe(Species ~ ., data = iris) %>%
    step_rm(contains("Sepal"))
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_pls + axe_env() works", {
  # recipes `step_pls()` was changed in 0.1.13 to use mixOmics under the hood
  skip_if_not_installed("mixOmics")

  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_pls(all_predictors, outcome = "HHV")
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_pca + axe_env() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_pca(all_numeric(), num_comp = 3)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_bagimpute + axe_env() works", {
  skip_if_recipes_post_0.1.16()

  rec <- recipe(Price ~ ., data = credit_tr) %>%
    step_bagimpute(Status, Home, Marital, Job, Income, Assets, Debt)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
  impute_empty_env(x, 1)
})
test_that("recipe + step_impute_bag + axe_env() works", {
  skip_if_recipes_pre_0.1.16()

  rec <- recipe(Price ~ ., data = credit_tr) %>%
    step_impute_bag(Status, Home, Marital, Job, Income, Assets, Debt)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
  impute_empty_env(x, 1)
})

test_that("recipe + step_classdist + axe_env() works", {
  rec <- recipe(Species ~ ., data = iris) %>%
    step_classdist(all_predictors(),
                   class = "Species",
                   pool = FALSE,
                   mean_func = mean)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_corr + axe_env() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_corr(all_numeric(), threshold = .5)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_depth + axe_env() works", {
  rec <- recipe(Species ~ ., data = iris) %>%
    step_depth(all_predictors(), class = "Species")
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_isomap + axe_env() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_isomap(all_predictors(), neighbors = 5, num_terms = 2)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_kpca + axe_env() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_kpca(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_lag + axe_env() works", {
  df <- data.frame(x = runif(20),
                   index = 1:20)
  rec <- recipe( ~ ., data = df) %>%
    step_lag(index, lag = 2:3)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_lincomb + axe_env() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_lincomb(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_meanimpute + axe_env() works", {
  skip_if_recipes_post_0.1.16()

  rec <- recipe(Price ~ ., data = credit_tr) %>%
    step_meanimpute(Income, Assets, Debt)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})
test_that("recipe + step_impute_mean + axe_env() works", {
  skip_if_recipes_pre_0.1.16()

  rec <- recipe(Price ~ ., data = credit_tr) %>%
    step_impute_mean(Income, Assets, Debt)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_medianimpute + axe_env() works", {
  skip_if_recipes_post_0.1.16()

  rec <- recipe(Price ~ ., data = credit_tr) %>%
    step_medianimpute(Income, Assets, Debt)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})
test_that("recipe + step_impute_median + axe_env() works", {
  skip_if_recipes_pre_0.1.16()

  rec <- recipe(Price ~ ., data = credit_tr) %>%
    step_impute_median(Income, Assets, Debt)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_modeimpute + axe_env() works", {
  skip_if_recipes_post_0.1.16()

  rec <- recipe(Price ~ ., data = credit_tr) %>%
    step_modeimpute(Income, Assets, Debt)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})
test_that("recipe + step_impute_mode + axe_env() works", {
  skip_if_recipes_pre_0.1.16()

  rec <- recipe(Price ~ ., data = credit_tr) %>%
    step_impute_mode(Income, Assets, Debt)
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_naomit + axe_env() works", {
  rec <- recipe( ~ ., data = Sacramento) %>%
    step_naomit(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + step_nzv + axe_env() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_nzv(all_predictors())
  x <- axe_env(rec)
  terms_empty_env(x, 1)
})

test_that("recipe + axe_fitted() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_nzv(all_predictors())
  x <- axe_fitted(rec)
  expect_identical(x$template, as_tibble(biomass_tr[integer(), ]))
})

test_that("recipe + bake() works", {
  rec <- recipe(HHV ~ ., data = biomass_tr) %>%
    step_nzv(all_predictors()) %>%
    prep()
  x <- butcher(rec)
  expect_identical(bake(x, biomass_te), bake(rec, biomass_te))
})
