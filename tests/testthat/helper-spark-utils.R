# NOTE: See `test-spark.R`

# # Spark objects are too large, so we create them on the fly
# # Source: https://github.com/rstudio/sparklyr
# spark_install_winutils <- function(version) {
#   hadoop_version <- if (version < "2.0.0") "2.6" else "2.7"
#   spark_dir <- paste("spark-", version, "-bin-hadoop", hadoop_version, sep = "")
#   winutils_dir <- file.path(Sys.getenv("LOCALAPPDATA"), "spark", spark_dir, "tmp", "hadoop", "bin", fsep = "\\")
#
#   if (!dir.exists(winutils_dir)) {
#     message("Installing winutils...")
#
#     dir.create(winutils_dir, recursive = TRUE)
#     winutils_path <- file.path(winutils_dir, "winutils.exe", fsep = "\\")
#
#     download.file(
#       "https://github.com/steveloughran/winutils/raw/master/hadoop-2.6.0/bin/winutils.exe",
#       winutils_path,
#       mode = "wb"
#     )
#
#     message("Installed winutils in ", winutils_path)
#   }
# }
#
# testthat_spark_connection <- function() {
#   if (!exists(".testthat_latest_spark", envir = .GlobalEnv))
#     assign(".testthat_latest_spark", "2.3.0", envir = .GlobalEnv)
#   livy_version <- Sys.getenv("LIVY_VERSION")
#   if (nchar(livy_version) > 0)
#     testthat_livy_connection()
#   else
#     testthat_shell_connection()
# }
#
# testthat_livy_connection <- function() {
#   version <- Sys.getenv("SPARK_VERSION", unset = testthat_latest_spark())
#   livy_version <- Sys.getenv("LIVY_VERSION", "0.5.0")
#
#   if (exists(".testthat_spark_connection", envir = .GlobalEnv)) {
#     spark_disconnect_all()
#     remove(".testthat_spark_connection", envir = .GlobalEnv)
#     Sys.sleep(3)
#   }
#
#   spark_installed <- spark_installed_versions()
#   if (nrow(spark_installed[spark_installed$spark == version, ]) == 0) {
#     spark_install(version)
#   }
#
#   if (nrow(livy_installed_versions()) == 0) {
#     cat("Installing Livy.")
#     livy_install(livy_version, spark_version = version, )
#     cat("Livy installed.")
#   }
#
#   expect_gt(nrow(livy_installed_versions()), 0)
#
#   # generate connection if none yet exists
#   connected <- FALSE
#   if (exists(".testthat_livy_connection", envir = .GlobalEnv)) {
#     sc <- get(".testthat_livy_connection", envir = .GlobalEnv)
#     connected <- TRUE
#   }
#
#   if (Sys.getenv("INSTALL_WINUTILS") == "true") {
#     spark_install_winutils(version)
#   }
#
#   if (!connected) {
#     livy_service_start(
#       version = livy_version,
#       spark_version = version,
#       stdout = FALSE,
#       stderr = FALSE)
#
#     sc <- spark_connect(
#       master = "http://localhost:8998",
#       method = "livy",
#       config = list(
#         sparklyr.verbose = TRUE,
#         sparklyr.connect.timeout = 120,
#         sparklyr.log.invoke = "cat"
#       ),
#       sources = TRUE
#     )
#
#     assign(".testthat_livy_connection", sc, envir = .GlobalEnv)
#   }
#
#   get(".testthat_livy_connection", envir = .GlobalEnv)
# }
#
#
# testthat_shell_connection <- function() {
#   version <- Sys.getenv("SPARK_VERSION", unset = testthat_latest_spark())
#
#   if (exists(".testthat_livy_connection", envir = .GlobalEnv)) {
#     spark_disconnect_all()
#     Sys.sleep(3)
#     livy_service_stop()
#     remove(".testthat_livy_connection", envir = .GlobalEnv)
#   }
#
#   spark_installed <- spark_installed_versions()
#   if (nrow(spark_installed[spark_installed$spark == version, ]) == 0) {
#     options(sparkinstall.verbose = TRUE)
#     spark_install(version)
#   }
#
#   stopifnot(nrow(spark_installed_versions()) > 0)
#
#   # generate connection if none yet exists
#   connected <- FALSE
#   if (exists(".testthat_spark_connection", envir = .GlobalEnv)) {
#     sc <- get(".testthat_spark_connection", envir = .GlobalEnv)
#     connected <- connection_is_open(sc)
#   }
#
#   if (Sys.getenv("INSTALL_WINUTILS") == "true") {
#     spark_install_winutils(version)
#   }
#
#   if (!connected) {
#     config <- spark_config()
#
#     options(sparklyr.sanitize.column.names.verbose = TRUE)
#     options(sparklyr.verbose = TRUE)
#     options(sparklyr.na.omit.verbose = TRUE)
#     options(sparklyr.na.action.verbose = TRUE)
#
#     config[["sparklyr.shell.driver-memory"]] <- "3G"
#     config[["sparklyr.apply.env.foo"]] <- "env-test"
#
#     setwd(tempdir())
#     sc <- spark_connect(master = "local", version = version, config = config)
#     assign(".testthat_spark_connection", sc, envir = .GlobalEnv)
#   }
#
#   # retrieve spark connection
#   get(".testthat_spark_connection", envir = .GlobalEnv)
# }
#
# testthat_latest_spark <- function() get(".testthat_latest_spark", envir = .GlobalEnv)
#
