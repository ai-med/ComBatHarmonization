# Authors: Sebastian Pölsterl
# The code is under the Artistic License 2.0.
# If using this code, make sure you agree and accept this license.

args = commandArgs(trailingOnly=TRUE)
if (length(args) != 3) {
    error("Exactly 3 arguments must be supplied.")
}

options(mc.cores = 4)

library(rstan)
library(parallel)
library(bridgesampling)
library(hdf5r)

h5 <- H5File$new(args[2], mode="r")
x <- t(h5[["data"]][["X"]]$read())
y <- matrix(NA, nrow=nrow(x), ncol=1)
y[, 1] <- h5[["data"]][["Y"]]$read()
h5$close_all()

if (nrow(x) <= ncol(x)) error("more features than samples")

dat.ca <- list(
    N = nrow(x),
    K = ncol(x),
    x = x,
    y = y[, 1],
    alpha = 2.0,
    beta = 1.0
)

model.ca <- stan_model(file = './causal_model_bridge.stan',
                       model_name = "causal_model_bridge", auto_write = TRUE)
fit.ca <- sampling(model.ca, data = dat.ca, iter = 8000, warmup = 1500, chains = 4, seed = 20912)
bridge.ca <- bridge_sampler(fit.ca, repetitions=10, silent=TRUE, cores=1)

cat("## CAUSAL")
print(summary(bridge.ca))

dat.co <- list(
    N = nrow(x),
    K = ncol(x),
    DZ = as.integer(args[1]),
    x = x,
    y = y[, 1]
)

model.co <- stan_model(file = './confounded_model_bridge.stan',
		       model_name = "confounded_model_bridge", auto_write = TRUE)
fit.co <- sampling(model.co, data = dat.co, iter = 8000, warmup = 1500, chains = 4, seed = 20912)
bridge.co <- bridge_sampler(fit.co, repetitions=10, silent=TRUE, cores=1, maxiter=2500)

cat("## CONFOUNDED")
print(summary(bridge.co))

if (mean(bridge.ca$logml) > mean(bridge.co$logml)) {
    bf.out <- bf(bridge.ca, bridge.co)
} else {
    bf.out <- bf(bridge.co, bridge.ca)
}

res <- data.frame(
    ll_causal=bridge.ca$logml,
    ll_confounded=bridge.co$logml,
    bayes_factor=bf.out$bf
)
write.csv(res, args[3])
