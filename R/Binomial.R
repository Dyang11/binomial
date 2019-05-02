
check_prob <- function(prob) {
  if (prob <= 1 & prob >= 0){
    return (TRUE)
  }
  else {
    stop ("P has to be a number between 0 and 1")
  }
}

check_trials <- function(trials) {
  if (is.numeric(trials) & trials > 0) {
    return (TRUE)
  }
  else {
    stop ("Invalid trials number: must be a positive integer")
  }
}

check_success <- function(success, trials){
  for (i in 1:length(success)) {
    if (success[i] > trials | success[i] < 0){
      stop ("Invalid success vales: successes must be between 0 and the # of trials")
    }
  }
  return (TRUE)
}

aux_mean <- function(trials,prob){
  mean <- trials * prob
  return (mean)
}

aux_variance <- function(trials,prob){
  variance <- (trials* prob * (1-prob))
  return (variance)
}

aux_mode <- function(trials,prob){
  store_var <- ((trials*prob) + prob)
  if (store_var %% 1 == 0) {
    mode <- c(store_var, store_var-1)
  }
  else {
    mode <- floor(store_var)
  }
  return (mode)
}

aux_skewness <- function(trials,prob){
  skewness <- ((1-(2*prob))/(sqrt(trials*prob*(1-prob))))
  return (skewness)
}

aux_kurtosis <- function(trials,prob){
  kurtosis <- ((1-(6*prob*(1-prob)))/(trials * prob * (1-prob)))
  return(kurtosis)
}

#' @title Bin Choose
#' @description A function to calculate the number of combinations in which k successes can occur in n trials.
#' @param n an integer, the number of trials
#' @param k an integer or vector of numbers, the value of successes
#' @return an integer, the number of combinations for k successes in n trials
#' @examples
#' bin_choose(10,7)
#' bin_choose(10,5)
#' @export
bin_choose <- function(n,k){
  if (sum(which(k > n)) > 0){
    stop("k cannot be greater than n")
  }
  total_comb <- (factorial(n)/(factorial(k)*factorial(n-k)))
  return (total_comb)
}

#' @title Bin Probability
#' @description A function to calculate the probability of getting k successes in n trials given p probability.
#' @param trials an integer, the number of trials
#' @param success an integer or vector of numbers, the value of successes
#' @param prob an integer of the probability of success for one trial
#' @return an integer, the probability of getting the specified number of successes within given trials assuming the give probability of success
#' @examples
#' bin_probability(4,7,0.5)
#' @export
bin_probability <- function(success,trials,prob) {
  check_trials(trials)
  check_prob(prob)
  check_success(success,trials)
  number_comb <- bin_choose(trials,success)
  probability <- ((number_comb) * (prob^success)*((1-prob)^(trials-success)))
  return(probability)
}

#' @title Bin Distribution
#' @description A function to create a data frame displaying the probability for all possible number of successes given the number of trials and the probability of success.
#' @param trials an integer, the number of trials
#' @param prob an integer of the probability of success for one trial
#' @return a data frame with the probability for all possible number of successes given the number of trials and the probability of success.
#' @examples
#' bin_distribution(10,0.5)
#' @export
bin_distribution <- function(trials,prob){
  data_export <- data.frame(successes = 0:trials, prob = rep(0,trials+1))
  for (i in 0:trials) {
    data_export$prob[i+1] = bin_probability(i,trials,prob)
  }
  class(data_export) <- c("bindis","data.frame")
  return (data_export)
}

#' @export
plot.bindis <- function(chart){
  ggplot(chart, aes(su?ccesses,prob))+geom_bar(stat="identity") +
  ggtitle("Distribution of Successes") +
  scale_x_continuous(name = "# of Successes", breaks = 0:length(chart$successes)) +
  scale_y_continuous(name = "Probability of Achieving X successes") +
  theme_classic()
}

#' @title Bin Cumulative
#' @description A function to create a data frame displaying the probability for all possible number of successes given the number of trials and the probability of success, along with the culmulative probability.
#' @param trials an integer, the number of trials
#' @param prob an integer of the probability of success for one trial
#' @return a data frame with the probability for all possible number of successes given the number of trials, the probability of success, and the cumulutaive probability of success for all successes values before.
#' @examples
#' bin_cumulative(10,0.5)
#' @export
bin_cumulative <- function(trials,prob){
  data_export <- bin_distribution(trials,prob)
  cumulative_value <- data_export$prob[1]
  data_export$cumulative <- c(cumulative_value,rep(0,trials))
  for (i in 1:trials){
    cumulative_value = cumulative_value + data_export$prob[i+1]
    data_export$cumulative[i+1] = cumulative_value
  }
  class(data_export) <- c("bincum","data.frame")
  return(data_export)
}

#' @export
plot.bincum <- function(chart){
  ggplot(chart,aes(x=successes)) +
  geom_line(aes(y=cumulative)) +
  geom_point(aes(y=cumulative),size = 1.5) +
  geom_area(aes(y=cumulative),alpha = 0.5) +
  ggtitle("Binomial Cumulative Distribution") +
  scale_x_continuous(name = "# of Successes", breaks = 0:length(chart$successes)) +
  scale_y_continuous(name = "Cumulative Probability") +
  theme_classic()
}

#' @title Bin Variables
#' @description A function to create a binvar object with the given trials and probability
#' @param trials an integer, the number of trials
#' @param prob an integer of the probability of success for one trial
#' @return a named list of the "binvar" class with the trials and the probability
#' @examples
#' bin_variable(10,0.3)
#' @export
bin_variable <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  export <- c(trials,prob)
  class(export) <- "binvar"
  names(export) <- c("trials","prob")
  return (export)
}

#' @export
print.binvar <- function(list){
  cat("\"Binomial Varaible\"\n\nParameters\n- number of trials: ",list["trials"],"\n- prob of success : ", list["prob"])
}

#' @export
summary.binvar <- function(binvar){
  export <- binvar
  trials = binvar["trials"]
  prob = binvar["prob"]
  mode <- aux_mode(trials,prob)
  if (length(mode) > 1) {
    mode <- paste0(mode[1],", ",mode[2])
  }
  export <- c(trials,prob,aux_mean(trials,prob),aux_variance(trials,prob),aux_skewness(trials,prob),aux_kurtosis(trials,prob),mode)
  names(export) <- c("trials","prob","mean","variance","skewness","kurtosis","mode")
  class(export) <- "summary.binvar"
  return(export)
}

#' @export
print.summary.binvar <- function(summary) {
  cat("\"Summary Binomial\"\n\nParameters\n- number of trials:",summary["trials"])
  cat("\n- prob of success :",summary["prob"],"\n\nMeasures\n- mean    :",summary["mean"])
  cat("\n- variance:",summary["variance"],"\n- mode(s) :",summary["mode"])
  cat("\n- skewness:",summary["skewness"],"\n- kurtosis:",summary["kurtosis"])
}

#' @title Bin Mean
#' @description A function to return the mean of a binomial distribution with given trials and probability
#' @param trials an integer, the number of trials
#' @param prob an integer of the probability of success for one trial
#' @return an integer, the mean of successes in the given amount of trials
#' @examples
#' bin_mean(10,0.5)
#' @export
bin_mean <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  mean <- aux_mean(trials,prob)
  return (mean)
}

#' @title Bin Variance
#' @description A function to return the variance of a binomial distribution with given trials and probability
#' @param trials an integer, the number of trials
#' @param prob an integer of the probability of success for one trial
#' @return an integer, the variance
#' @examples
#' bin_variance(10,0.5)
#' @export
bin_variance <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  variance <- aux_variance(trials,prob)
  return (variance)
}

#' @title Bin Mode
#' @description A function to return the mode of a binomial distribution with given trials and probability
#' @param trials an integer, the number of trials
#' @param prob an integer of the probability of success for one trial
#' @return an integer or list of integers, if there are multiple modes
#' @examples
#' bin_mode(3,0.5)
#' @export
bin_mode <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  mode <- aux_mode(trials,prob)
  return (mode)
}

#' @title Bin Skewness
#' @description A function to return the skewness of a binomial distribution with given trials and probability
#' @param trials an integer, the number of trials
#' @param prob an integer of the probability of success for one trial
#' @return an integer, the skewness
#' @examples
#' bin_skewness(10,0.5)
#' @export
bin_skewness <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  skewness <- aux_skewness(trials,prob)
  return (skewness)
}

#' @title Bin Kurtosis
#' @description A function to return the kurtosis of a binomial distribution with given trials and probability
#' @param trials an integer, the number of trials
#' @param prob an integer of the probability of success for one trial
#' @return an integer, the kurtosis
#' @examples
#' bin_kurtosis(10,0.5)
#' @export
bin_kurtosis <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  kurtosis <- aux_kurtosis(trials,prob)
  return (kurtosis)
}

