# for keras
nnet_spec <-
  mlp(
    hidden_units = varying(),
    epochs = varying(),
    dropout = varying()
  ) %>%
  set_engine(
    "keras",
    batch_size = varying(),
    callbacks = callback_early_stopping(monitor = 'loss', min_delta = varying())
  )

varying_args(nnet_spec)
