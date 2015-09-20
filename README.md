# sgtreg
Skewed Generalized T Regression Stata Package

This is a Stata package that fits a skewed generalized t regression model to data. The standard linear regression model typically assumes that the errors are independently and identically distributed. The corresponding ordinary least squares (OLS) estimator will yield the best linear approximation of the conditional mean. This regression method, which uses the skewed generalize t (SGT) distribution, can accommodate situations in which the conditional mean, variance and skewness of a variable of interest may vary as a function of independent variables. This method is described in the paper "A Generalized Regression Specification using the Skewed Generalized T Distribution", by Carter Davis, James McDonald, and Daniel Walton.

# Installation

Get the released version from the Boston College Statistical Software Components (SSC) archive:
```
ssc install sgtreg
```

Or the development version from github:
```
net install sgtreg, from(https://raw.githubusercontent.com/carterkd/sgtreg/master/)
```
