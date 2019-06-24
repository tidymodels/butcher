context("recipe")

library(rsample)
library(recipes)
library(lubridate)

# For testing purposes
test_en <- rlang::empty_env()

# Reused data
data(biomass)
biomass_tr <- biomass[biomass$dataset == "Training",]

data("credit_data")
set.seed(55)
train_test_split <- initial_split(credit_data)
credit_tr <- training(train_test_split)

test_that("recipe + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_center(all_predictors()) %>%
    step_scale(all_predictors()) %>%
    step_spatialsign(all_predictors())
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[2]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[3]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_knnimpute + axe_env() works", {
  rec <- recipe(credit_tr) %>%
    step_knnimpute(all_predictors())
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[1]]$impute_with[[1]], ".Environment"), test_en)
})

test_that("recipe + step_lowerimpute + axe_env() works", {
  rec <- recipe(credit_tr) %>%
    step_lowerimpute(Time, Expenses, threshold = c(40,40))
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_rollimpute + axe_env() works", {
  rec <- recipe(credit_tr) %>%
    step_rollimpute(Time, statistic = median, window = 3)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_BoxCox + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_BoxCox(rec, all_numeric())
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_bs + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_bs(carbon, hydrogen)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_hyperbolic + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_hyperbolic(Income, func = "cos", inverse = FALSE)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_inverse + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_inverse(Income)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_invlogit + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_center(carbon, hydrogen) %>%
    step_scale(carbon, hydrogen) %>%
    step_invlogit(carbon, hydrogen)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[2]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[3]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_log + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_log(Income)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_logit + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_logit(Income)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_mutate + axe_env() works", {
  rec <- recipe( ~ ., data = iris) %>%
    step_mutate(
      dbl_width = Sepal.Width * 2,
      half_length = Sepal.Length / 2
    )
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$inputs[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[1]]$inputs[[2]], ".Environment"), test_en)
})

test_that("recipe + step_ns + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_ns(carbon, hydrogen)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[1]]$terms[[2]], ".Environment"), test_en)
})

test_that("recipe + step_poly + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_poly(carbon, hydrogen)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[1]]$terms[[2]], ".Environment"), test_en)
})

test_that("recipe + step_relu + axe_env() works", {
  rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
                data = biomass_tr) %>%
    step_relu(carbon, shift = 40)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_sqrt + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_sqrt(all_numeric())
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_YeoJohnson + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_YeoJohnson(all_numeric())
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_discretize + axe_env() works", {
  rec <- recipe(~ ., data = as.data.frame(state.x77)) %>%
    step_discretize(Income)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_bin2factor + axe_env() works", {
  rec <- recipe(~ description, covers) %>%
    step_regex(description, pattern = "(rock|stony)", result = "rocks") %>%
    step_regex(description, pattern = "(rock|stony)", result = "more_rocks") %>%
    step_bin2factor(rocks)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[2]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[3]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_count + axe_env() works", {
  rec <- recipe(~ description, covers) %>%
    step_count(description, pattern = "(rock|stony)", result = "rocks")
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_date + axe_env() works", {
  examples <- data.frame(Dan = ymd("2002-03-04") + days(1:10),
                         Stefan = ymd("2006-01-13") + days(1:10))
  rec <- recipe(~ Dan + Stefan, examples) %>%
    step_date(all_predictors())
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_dummy + axe_env() works", {
  rec <- recipe(~ diet + age + height, data = okc) %>%
    step_dummy(diet)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_string2factor + axe_env() works", {
  rec <- recipe(~ diet + age + height, data = okc) %>%
    step_string2factor(diet)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_factor2string + axe_env() works", {
  rec <- recipe(~ diet + age + height, data = okc) %>%
    step_string2factor(diet) %>%
    step_factor2string(diet)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[2]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_holiday + axe_env() works", {
  examples <- data.frame(someday = ymd("2000-12-20") + days(0:40))
  rec <- recipe(~ someday, examples) %>%
    step_holiday(all_predictors())
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_integer + axe_env() works", {
  rec <- recipe(Class ~ ., data = okc) %>%
    step_integer(all_predictors())
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_novel + axe_env() works", {
  okc_tr <- okc[1:30000,]
  okc_te <- okc[30001:30006,]
  okc_te$diet[3] <- "cannibalism"
  okc_te$diet[4] <- "vampirism"
  rec <- recipe(Class ~ ., data = okc_tr) %>%
    step_novel(diet, location)
  rec <- prep(rec, training = okc_tr)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_num2factor + axe_env() works", {
  iris2 <- iris
  iris2$Species <- as.numeric(iris2$Species)
  rec <- recipe(~ ., data = iris2) %>%
    step_num2factor(Species)
  rec <- recipe(Class ~ ., data = okc) %>%
    step_integer(all_predictors())
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
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
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[2]]$terms[[1]], ".Environment"), test_en)
})

test_that("recipe + step_other + axe_env() works", {
  rec <- recipe(~ diet + location, data = okc) %>%
    step_other(diet, location, threshold = .1, other = "other values")
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[1]]$terms[[2]], ".Environment"), test_en)
})

test_that("recipe + step_unorder + axe_env() works", {
  lmh <- c("Low", "Med", "High")
  examples <- data.frame(X1 = factor(rep(letters[1:4], each = 3)),
                         X2 = ordered(rep(lmh, each = 4),
                                      levels = lmh))
  rec <- recipe(~ X1 + X2, data = examples) %>%
    step_unorder(all_predictors())
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
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
  expect_identical(attr(x$steps[[1]]$terms[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[1]]$terms[[2]], ".Environment"), test_en)
})

test_that("recipe + step_geodist + axe_env() works", {
  data(Smithsonian)
  rec <- recipe( ~ ., data = Smithsonian) %>%
    update_role(name, new_role = "location") %>%
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
  expect_identical(attr(x$steps[[1]]$inputs[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[1]]$inputs[[2]], ".Environment"), test_en)
})

test_that("recipe + step_filter + axe_env() works", {
  rec <- recipe( ~ ., data = iris) %>%
    step_filter(Sepal.Length > 4.5, Species == "setosa")
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$inputs[[1]], ".Environment"), test_en)
  expect_identical(attr(x$steps[[1]]$inputs[[2]], ".Environment"), test_en)
})

test_that("recipe + step_slice + axe_env() works", {
  rec <- recipe( ~ ., data = iris) %>%
    step_slice(1:3)
  x <- axe_env(rec)
  expect_identical(attr(x$steps[[1]]$inputs[[1]], ".Environment"), test_en)
})


