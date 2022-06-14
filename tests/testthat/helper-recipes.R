skip_if_recipes_pre_0.2.1 <- function() {
  skip_if(
    condition = packageVersion("recipes") < "0.2.0.9001",
    message = "Skipping on old recipes (pre 0.2.1)"
  )
}
