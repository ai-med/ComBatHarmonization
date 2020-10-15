# Telling Causal from Confounded with Causal Inference

## Usage

```python
import numpy as np
from compare_models import compare_models

X = np.random.randn(100, 5)

beta = np.zeros(5)
beta[1:] = np.random.uniform(low=-1, high=1, size=4)
Y = X @ beta

result = compare_models(X, Y, DZ=1)
print(result)
```

This will print a table that lists the log-likelihood of
the causal and confounded model for 10 repetitions.
The higher log-likelihood of the causal model, suggests
that `X` is indeed the cause of `Y`.

| iter | ll_causal | ll_confounded | bayes_factor |
| ---- | --------- | ------------- | ------------ |
| 1 | -479.039789 | -822.107921 | 9.830969e+148 |
| 2 | -479.040413 | -822.155958 | 1.030832e+149 |
| 3 | -479.041873 | -822.185778 | 1.060485e+149 |
| 4 | -479.038676 | -822.201896 | 1.081167e+149 |
| 5 | -479.040882 | -822.394069 | 1.307358e+149 |
| 6 | -479.040289 | -821.986750 | 8.704735e+148 |
| 7 | -479.042047 | -822.151386 | 1.024454e+149 |
| 8 | -479.041100 | -822.115588 | 9.893665e+148 |
| 9 | -479.041621 | -822.332420 | 1.228286e+149 |
| 10 | -479.039873 | -821.870923 | 7.755917e+148 |


## Installation

For our experiments, we used R version 3.6.2 with the following packages:

| Package | Version |
| ------- | ------- |
| abind | 1.4-5 |
| askpass | 1.1 |
| assertthat | 0.2.1 |
| backports | 1.1.5 |
| base64enc | 0.1-3 |
| bayesplot | 1.7.1 |
| betareg | 3.1-3 |
| BH | 1.72.0-3 |
| bit | 1.1-15.2 |
| bit64 | 0.9-7.1 |
| bridgesampling | 1.0-0 |
| brms | 2.12.0 |
| Brobdingnag | 1.2-6 |
| callr | 3.4.2 |
| checkmate | 2.0.0 |
| cli | 2.0.2 |
| coda | 0.19-3 |
| colorspace | 1.4-1 |
| colourpicker | 1.0 |
| crayon | 1.3.4 |
| crosstalk | 1.0.0 |
| curl | 4.3 |
| desc | 1.2.0 |
| digest | 0.6.25 |
| dplyr | 0.8.4 |
| DT | 0.12 |
| dygraphs | 1.1.1.6 |
| ellipsis | 0.3.0 |
| evaluate | 0.14 |
| fansi | 0.4.1 |
| farver | 2.0.3 |
| fastmap | 1.0.1 |
| filehash | 2.4-2 |
| flexmix | 2.3-15 |
| Formula | 1.2-3 |
| future | 1.16.0 |
| ggplot2 | 3.2.1 |
| ggridges | 0.5.2 |
| globals | 0.12.5 |
| glue | 1.3.1 |
| gridExtra | 2.3 |
| gtable | 0.3.0 |
| gtools | 3.8.1 |
| hdf5r | 1.3.2 |
| htmltools | 0.4.0 |
| htmlwidgets | 1.5.1 |
| httpuv | 1.5.2 |
| igraph | 1.2.4.2 |
| inline | 0.3.15 |
| IRdisplay | 0.7.0 |
| IRkernel | 1.1 |
| jsonlite | 1.6.1 |
| labeling | 0.3 |
| later | 1.0.0 |
| lazyeval | 0.2.2 |
| lifecycle | 0.1.0 |
| listenv | 0.8.0 |
| lme4 | 1.1-21 |
| lmtest | 0.9-37 |
| loo | 2.2.0 |
| magrittr | 1.5 |
| markdown | 1.1 |
| matrixStats | 0.55.0 |
| mime | 0.9 |
| miniUI | 0.1.1.1 |
| minqa | 1.2.4 |
| modeltools | 0.2-22 |
| munsell | 0.5.0 |
| mvtnorm | 1.1-0 |
| nleqslv | 3.3.2 |
| nloptr | 1.2.1 |
| openssl | 1.4.1 |
| packrat | 0.5.0 |
| pbdZMQ | 0.3-3 |
| pillar | 1.4.3 |
| pkgbuild | 1.0.6 |
| pkgconfig | 2.0.3 |
| plogr | 0.2.0 |
| plyr | 1.8.5 |
| png | 0.1-7 |
| prettyunits | 1.1.1 |
| processx | 3.4.2 |
| promises | 1.1.0 |
| ps | 1.3.2 |
| purrr | 0.3.3 |
| R6 | 2.4.1 |
| RColorBrewer | 1.1-2 |
| Rcpp | 1.0.3 |
| RcppEigen | 0.3.3.7.0 |
| RcppParallel | 4.4.4 |
| repr | 1.1.0 |
| reshape2 | 1.4.3 |
| rlang | 0.4.5 |
| rprojroot | 1.3-2 |
| rsconnect | 0.8.16 |
| rstan | 2.19.3 |
| rstanarm | 2.19.3 |
| rstantools | 2.0.0 |
| rstudioapi | 0.11 |
| sandwich | 2.5-1 |
| scales | 1.1.0 |
| shiny | 1.4.0 |
| shinyjs | 1.1 |
| shinystan | 2.5.0 |
| shinythemes | 1.1.2 |
| sourcetools | 0.1.7 |
| StanHeaders | 2.21.0-1 |
| stringi | 1.4.6 |
| stringr | 1.4.0 |
| sys | 3.3 |
| threejs | 0.3.3 |
| tibble | 2.1.3 |
| tidyselect | 1.0.0 |
| tikzDevice | 0.12.3 |
| utf8 | 1.1.4 |
| uuid | 0.1-4 |
| vctrs | 0.2.3 |
| viridisLite | 0.3.0 |
| withr | 2.1.2 |
| xfun | 0.12 |
| xtable | 1.8-4 |
| xts | 0.12-0 |
| yaml | 2.2.1 |
| zeallot | 0.1.0 |
| zoo | 1.8-7 |

## Acknowledgments

Our approach to compare causal and confounded models via minimum description length (MDL)
is based on
```
Kaltenpoth, D., Vreeken, J., 2019. We are not your real parents: Telling causal from confounded by MDL. In: SIAM International Conference on Data Mining.
```