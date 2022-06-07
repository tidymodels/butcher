skip_if_recipes_pre_0.1.16 <- function() {
  skip_if(
    condition = packageVersion("recipes") < "0.1.15.9000",
    message = "Skipping on old recipes (pre 0.1.16)"
  )
}

skip_if_recipes_post_0.1.16 <- function() {
  skip_if(
    condition = packageVersion("recipes") >= "0.1.15.9000",
    message = "Skipping on new recipes where no longer applicable (post 0.1.16)"
  )
}

skip_if_recipes_pre_0.2.1 <- function() {
  skip_if(
    condition = packageVersion("recipes") < "0.2.0.9001",
    message = "Skipping on old recipes (pre 0.2.1)"
  )
}
