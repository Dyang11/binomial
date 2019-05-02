context("Checker")

test_that("check_prob catches the correct errors", {
  x <- 1.1
  y <- "A"
  z <- 1.0
  expect_error (check_prob(x),"P has to be a number between 0 and 1")
  expect_error (check_prob(y),"P has to be a number between 0 and 1")
  expect_true (check_prob(z))
  })

test_that("check_prob confrims that prob is a valid integer", {
  x <- 0.5
  y <- c(0.5,0.6)
  expect_equal (check_prob(x), x>= 0 & x <= 1)
  expect_equal (check_prob(x),length(x) == 1)
  expect_error (check_prob(y), "The probability must be a single number")
  })

test_that("check_trials catches the correct errors", {
  x <- -1
  y <- "A"
  z <- 100
  expect_error (check_trials(x), "Invalid trials number: must be a positive integer")
  expect_error (check_trials(y), "Invalid trials number: must be a positive integer")
  expect_true (check_trials(z))
  })

test_that("check_trials passes the valid trial numbers",{
  x <- 1
  y <- c(1,2)
  expect_equal (check_trials(x), x > 0)
  expect_equal (check_trials(x), length(x) == 1)
  expect_error (check_trials(y), "The number of trials must be a single integer")
})

test_that("check_success catches the correct errors", {
  x <- 1
  y <- c(1,2)
  z <- 6
  a <- "A"
  trials <- 5
  expect_error (check_success(z,trials), "Invalid success values: successes must be between 0 and the # of trials")
  expect_error (check_success(a,trials), "Invalid success values: successes must be between 0 and the # of trials")
  expect_true (check_success(x,trials))
  expect_true (check_success(y,trials))
  expect_equal (check_success(x,trials), is.integer (x) | is.vector(x))
  expect_equal (check_success(y,trials), is.integer (y) | is.vector(y))
})


