# ComBat++ harmonization 

ComBat++ is an extension of ComBat by also modeling non-biological covariates, which we would like to remove from the data. As in Combat, it estimates site-specific location and scale parameters, and accounts for biological covariates. ComBat pools information across features using empirical Bayes to improve the estimation of those parameters for small sample size studies. The details are described in Section 5 in (Wachinger et al., MedIA, https://arxiv.org/abs/2002.05049). 

### ComBat++

The  `combatPP` function is the main function. It requires two mandatory arguments:
- a data matrix (p x n) `dat` for which the p rows are features, and the n columns are participants. 
- a numeric or character vector `batch` of length n indicating the site/scanner/study id. 

For illustration purpose, let's simulate an imaging dataset with n=10 participants, acquired on 2 sites, with 5 participants each, with p=9 variables per scan: 

```r
source("utils.R");
source("combatPP.R")
p <- 8
n <- 10
batch <- c(1,1,1,1,1,2,2,2,2,2) #Batch variable for the scanner id
dat <- matrix(runif(p*n), p, n) #Random Data matrix
```

We consider biological covariates that should be preserved in the harmonization, e.g., age and disease:
```r
age <- c(82,70,68,66,80,69,72,76,74,80) # Continuous variable
disease <- as.factor(c(1,2,1,2,1,2,1,2,1,2)) # Categorical variable
mod <- model.matrix(~age+disease)
```

In ComBat++, we further model non-biological covariates that we would like to remove. This can be known variation from variables like magnetic field strength (MFS) and manufacturer, or unknown variation, which we compute with PCA. In the example, we consider 5 scans on 1.5T and 5 scans on 3.0T machines: 

```r
MFS <- as.factor(c(1,1,1,2,2,2,1,1,2,2)) # Categorical variable
mod_remove <- model.matrix(~ MFS)

prcomps <- princomp(t(dat))
PCs <- predict(prcomps,t(dat))

var_remove <- cbind(mod_remove,PCs[,c(1,2)])
```

With all the variables prepared, we call ComBat++ and have the harmonized data in `data.harmonized$dat.combat`:

```r
data.harmonized <- combatPP( dat=dat, PC=var_remove, mod=mod, batch=batch)
```

The `data.harmonized` object also contains the different parameters estimated by ComBat:
- `gamma.hat` and `delta.hat`: Estimated location and shift (L/S) parameters before empirical Bayes.
- `gamma.star` and `delta.star`: Empirical Bayes estimated L/S parameters.
- `gamma.bar`, `t2`, `a.prior` and `b.prior`: esimated prior distributions parameters.


### References

ComBat++ is published in (https://arxiv.org/abs/2002.05049). It is based on ComBat, which was orgiginally proposed for gene expression data (https://doi.org/10.1093/biostatistics/kxj037) and later applied to neuroimaging (https://doi.org/10.1016/j.neuroimage.2017.11.024). 




