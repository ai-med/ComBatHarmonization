# ComBat++ harmonization in R

## Multi-Site Harmonization

ComBat++ estimates scanner-specific location and scale parameters, for each feature separately, and pools information across features using empirical Bayes to improve the estimation of those parameters for small sample size studies.  

### ComBat++

The  `combatPP` function is the main function. It requires two mandatory arguments:
- a data matrix (p x n) `dat` for which the p rows are features, and the n columns are participants. 
- a numeric or character vector `batch` of length n indicating the site/scanner/study id. 

For illustration purpose, let's simulate an imaging dataset with n=10 participants, acquired on 2 scanners, with 5 participants each, with p=9 variables per scan. 

```r
source("utils.R");
source("combatPP.R")
p=8
n=10
batch = c(1,1,1,1,1,2,2,2,2,2) #Batch variable for the scanner id
dat = matrix(runif(p*n), p, n) #Random Data matrix
```

Biological covariates that should be preserved in the harmonization, e.g., age and disease
```r
age <- c(82,70,68,66,80,69,72,76,74,80) # Continuous variable
disease <- as.factor(c(1,2,1,2,1,2,1,2,1,2)) # Categorical variable
mod <- model.matrix(~age+disease)
```

In ComBat++, we further model non-biological covariates that we would like to remove. This can be known variation from variables like magnetic field strength (MFS) and manufacturer, or unknown variation, which we compute with PCA. 

```r
MFS <- as.factor(c(1,1,1,2,2,2,1,1,2,2)) # Categorical variable
mod_remove <- model.matrix(~ MFS)

prcomps <- princomp(t(dat))
PCs <- predict(prcomps,t(dat))

var_remove=cbind(mod_remove,PCs[,c(1,2)])

data.harmonized <- combatPP( dat=dat, PC=var_remove, mod=mod, batch=batch)
```

The harmonized matrix is stored in `data.harmonized$dat.combat`. 

The `data.harmonized` object also contains the different parameters estimated by ComBat:
- `gamma.hat` and `delta.hat`: Estimated location and shift (L/S) parameters before empirical Bayes.
- `gamma.star` and `delta.star`: Empirical Bayes estimated L/S parameters.
- `gamma.bar`, `t2`, `a.prior` and `b.prior`: esimated prior distributions parameters.



### ComBat without empirical Bayes

Sometimes, it is preferable not to pool information across features, for instance if:
- (1) The number of features is substantially smaller than the number of participants (p << n) or
- (2) The prior distributions used in ComBat do not fit well the data
- (3) The site effects are only present for a small subset of features

An example of (2) is when the site/scanner effects are highly heteregenous across features, for instance differential scanner effects between white matter (WM) or grey matter (GM) voxels exist. To run the ComBat model without empirical Bayes, which boils down to fitting a location/shift (L/S) model for each feature separately, the option `eb=FALSE` can be used:

```r
data.harmonized <- combat(dat=dat, batch=batch, eb=FALSE)
```




