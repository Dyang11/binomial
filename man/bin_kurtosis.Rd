% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Binomial.R
\name{bin_kurtosis}
\alias{bin_kurtosis}
\title{Bin Kurtosis}
\usage{
bin_kurtosis(trials, prob)
}
\arguments{
\item{trials}{an integer, the number of trials}

\item{prob}{an integer of the probability of success for one trial}
}
\value{
an integer, the kurtosis
}
\description{
A function to return the kurtosis of a binomial distribution with given trials and probability
}
\examples{
bin_kurtosis(10,0.5)
}
