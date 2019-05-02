context("binomial")

trials <- 10
prob <- 0.7

x <- 5
y <- 11
z <- 1:11
a <- 1:3

test_that("bin_choose catches the right errors",{
  expect_error(bin_choose(trials,y),"k cannot be greater than n")
  expect_error(bin_choose(trials,z),"k cannot be greater than n")
})

test_that("bin_choose provides the correct output",{
  expect_equal(bin_choose(trials,x),252)
  expect_equal(bin_choose(trials,a),c(10,45,120))
  expect_true(is.numeric(bin_choose(trials,x)))
  expect_true(is.numeric(bin_choose(trials,a)))
})

test_that("bin_probability catches the right errors",{
  expect_error(bin_probability(y,trials,prob),"Invalid success values: successes must be between 0 and the # of trials")
  expect_error(bin_probability(x,trials,1.2), "P has to be a number between 0 and 1")
  expect_error(bin_probability(x,-1,prob), "Invalid trials number: must be a positive integer")
})

test_that("bin_probability provides the correct output",{
  expect_equal(bin_probability(1,2,prob),0.42)
  expect_equal(length(bin_probability(x,trials,prob)), length(x))
  expect_equal(length(bin_probability(a,trials,prob)), length(a))
  expect_true(is.numeric(bin_probability(a,trials,prob)))
})

test_that("bin_distribution catches the right errors", {
  expect_error(bin_distribution(trials,1.1), "P has to be a number between 0 and 1")
  expect_error(bin_distribution(-1,prob), "Invalid trials number: must be a positive integer")
})

test_that("bin_distribution creates the right output",{
  test <- bin_distribution(2,0.5)
  test_output <- data.frame(successes = 0:2,prob = c(0.25,0.5,0.25))
  class(test_output) <- c("bindis","data.frame")
  expect_true(length(class(test)) == 2)
  expect_equal(class(test), c("bindis", "data.frame"))
  expect_equal(test,test_output)
})

test_that("bin_distribution creates a plot ",{
  expect_true(is.ggplot(plot(bin_distribution(trials,prob))))
})

test_that("bin_cumulative catches the right errors",{
  expect_error(bin_cumulative(trials,1.1), "P has to be a number between 0 and 1")
  expect_error(bin_cumulative(-1,prob), "Invalid trials number: must be a positive integer")
})

test_that("bin_cumulative creates the right output",{
  test <- bin_cumulative(2,0.5)
  test_output <- data.frame(successes = 0:2,prob = c(0.25,0.5,0.25),cumulative = c(0.25,0.75,1))
  class(test_output) <- c("bincum","data.frame")
  expect_true(length(class(test)) == 2)
  expect_equal(class(test), c("bincum", "data.frame"))
  expect_equal(test,test_output)
})

test_that("bin_cumulative creates a plot ",{
  expect_true(is.ggplot(plot(bin_cumulative(trials,prob))))
})
