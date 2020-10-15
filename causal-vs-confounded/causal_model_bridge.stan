data {
  int<lower=0> N;              // num individuals
  int<lower=1> K;              // num predictors
  matrix[N, K] x;
  vector[N] y;
  real<lower=0> alpha;
  real<lower=0> beta;
}

parameters {
  real<lower=0> sigma_x;
  real<lower=0> sigma_y;
  vector[K] weights_y;
}

transformed parameters {
  vector[N] mu_y = x * weights_y;
}

model {
  target += inv_gamma_lpdf(sigma_x | alpha, beta);
  target += inv_gamma_lpdf(sigma_y | alpha, beta);
  target += normal_lpdf(weights_y | 0, 5);
  target += normal_lpdf(to_vector(x) | 0, sigma_x);
  target += normal_lpdf(y | mu_y, sigma_y);
}
