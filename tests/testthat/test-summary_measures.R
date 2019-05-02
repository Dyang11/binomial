context("Summary Measures")

trials <- 5
prob <- 0.5
prob2 <- 0.9

test_that("aux_mean returns the correct mean", {
  expect_identical(aux_mean(trials,prob), 2.5)
  expect_true(length(aux_mean(trials,prob)) == 1)
  expect_true(is.numeric(aux_mean(trials,prob)))
})

test_that("aux_variance returns the correct variance", {
  expect_identical(aux_variance(trials,prob), 1.25)
  expect_true(length(aux_variance(trials,prob)) == 1)
  expect_true(is.numeric(aux_variance(trials,prob)))
})

test_that("aux_mode returns the correct mode or modes", {
  expect_identical(aux_mode(trials,prob), c(3,2))
  expect_true(length(aux_mode(trials,prob)) == 1 | length(aux_mode(trials,prob)) == 2)
  expect_true(is.numeric(aux_variance(trials,prob)))
})

test_that("aux_skewness returns the correct skewness", {
  expect_identical(aux_skewness(trials,prob), 0)
  expect_true(length(aux_skewness(trials,prob)) == 1)
  expect_true(is.numeric(aux_skewness(trials,prob)))
})

test_that("aux_kurtosis returns the correct kurtosis", {
  expect_identical(aux_kurtosis(trials,prob), -0.4)
  expect_true(length(aux_kurtosis(trials,prob)) == 1)
  expect_true(is.numeric(aux_kurtosis(trials,prob)))
})


