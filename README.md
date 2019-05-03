
<!-- README.md is generated from README.Rmd. Please edit that file -->
Binomial
========

Overview:
---------

The *Binomial* pacakge provides functions to calculate and visualize binomial distirbutions.

A binomial distritbution can be generated with:

-   *n* trials
-   *p* probability

Basic summary functions calculate statistics of a generated binomial distribution:

-   `bin_mean(trials,probability)`
-   `bin_variance(n,p)`
-   `bin_mode(n,p)`
-   `bin_skewness(n,p)`
-   `bin_kurtosis(n,p)`

More complex summary funtions calculate the binomial distribution and the probability of successes:

-   `bin_variable(trials,probability)`
-   `bin_choose(trials,successes)`
-   `bin_probability(success,trials,probability)`
-   `bin_distribution(trials,probability)`
-   `bin_cumulative(trials,probability)`

To learn about these functions, read the vignette provided or call `?bin_variable`.

Installation:
-------------

Install the development version from GitHub via the package `"devtools"`:

``` r
# Load helper detools:
install.packages("devtools") 
# To load Binomial (without vignettes):
devtools::install_github("Dyang11/binomial")
```

To learn about the functions, install Binomail with vignettes:

``` r
devtools::install_github("Dyang11/binomial", build_vignettes = TRUE)
```

Usage:
------

Let us supposed we are simulating 10 coin tosses, where a "success" is a heads flip.

``` r
library(Binomial)

#Set variable amounts
trials <- 10
probability <- 0.5

bin_mean(trials,probability)
```

    ## [1] 5

``` r
bin_variable(trials,probability)
```

    ## "Binomial Varaible"
    ## 
    ## Parameters
    ## - number of trials:  10 
    ## - prob of success :  0.5

``` r
summary(bin_variable(trials,probability))
```

    ## "Summary Binomial"
    ## 
    ## Parameters
    ## - number of trials: 10
    ## - prob of success : 0.5 
    ## 
    ## Measures
    ## - mean    : 5
    ## - variance: 2.5 
    ## - mode(s) : 5
    ## - skewness: 0 
    ## - kurtosis: -0.2

``` r
bin_distribution(trials,probability)
```

    ##    successes         prob
    ## 1          0 0.0009765625
    ## 2          1 0.0097656250
    ## 3          2 0.0439453125
    ## 4          3 0.1171875000
    ## 5          4 0.2050781250
    ## 6          5 0.2460937500
    ## 7          6 0.2050781250
    ## 8          7 0.1171875000
    ## 9          8 0.0439453125
    ## 10         9 0.0097656250
    ## 11        10 0.0009765625

``` r
plot(bin_distribution(trials,probability))
```

![](README_files/figure-markdown_github/unnamed-chunk-1-1.png)

``` r
bin_cumulative(trials,probability)
```

    ##    successes         prob   cumulative
    ## 1          0 0.0009765625 0.0009765625
    ## 2          1 0.0097656250 0.0107421875
    ## 3          2 0.0439453125 0.0546875000
    ## 4          3 0.1171875000 0.1718750000
    ## 5          4 0.2050781250 0.3769531250
    ## 6          5 0.2460937500 0.6230468750
    ## 7          6 0.2050781250 0.8281250000
    ## 8          7 0.1171875000 0.9453125000
    ## 9          8 0.0439453125 0.9892578125
    ## 10         9 0.0097656250 0.9990234375
    ## 11        10 0.0009765625 1.0000000000

``` r
plot(bin_cumulative(trials,probability))
```

![](README_files/figure-markdown_github/unnamed-chunk-1-2.png)

------------------------------------------------------------------------

Created by Daniel Yang for Stat 133, Spring 2019. 05/03/19
